import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/budget.dart';
import '../../services/smart_budget_service.dart';
import '../../services/budget_service.dart';
import '../../services/ai_service_interface.dart';
import '../../services/ai_factory.dart';
import '../../services/firebase_config_service.dart';
import '../../services/budget_ai_prompts.dart';
import '../../utils/constants.dart';
import '../settings/settings_bloc.dart';
import 'smart_budget_event.dart';
import 'smart_budget_state.dart';

class SmartBudgetBloc extends Bloc<SmartBudgetEvent, SmartBudgetState> {
  final SmartBudgetService _smartBudgetService;
  final BudgetService _budgetService;
  // ignore: unused_field
  final SettingsBloc _settingsBloc;
  final FirebaseAuth _firebaseAuth;
  final FirebaseConfigService _firebaseConfigService;
  AIService? _aiService;

  SmartBudgetBloc({
    SmartBudgetService? smartBudgetService,
    BudgetService? budgetService,
    required SettingsBloc settingsBloc,
    FirebaseAuth? firebaseAuth,
    FirebaseConfigService? firebaseConfigService,
  })  : _smartBudgetService = smartBudgetService ?? SmartBudgetService(),
        _budgetService = budgetService ?? BudgetService(),
        _settingsBloc = settingsBloc,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseConfigService = firebaseConfigService ?? FirebaseConfigService(),
        super(const SmartBudgetState.initial()) {
    on<GenerateSmartBudget>(_onGenerateSmartBudget);
    on<ApplySmartBudget>(_onApplySmartBudget);
    on<RecalculateBudget>(_onRecalculateBudget);

    _initializeAI();
  }

  Future<void> _initializeAI() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        _aiService = null;
        return;
      }

      // Fetch API key from Firebase (per user)
      final apiKey = await _firebaseConfigService.getGeminiApiKey(user.uid);
      
      _aiService = AIFactory.createService(
        apiKey: apiKey,
      );
    } catch (e) {
      print('Error initializing AI for smart budget: $e');
      _aiService = null;
    }
  }

  Future<void> _onGenerateSmartBudget(
    GenerateSmartBudget event,
    Emitter<SmartBudgetState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const SmartBudgetState.error('User not authenticated'));
      return;
    }

    if (_aiService == null) {
      emit(const SmartBudgetState.error('AI service not configured. Please check settings.'));
      return;
    }

    emit(const SmartBudgetState.analyzing());

    try {
      // Step 1: Fetch last 3 months transactions
      final transactions = await _smartBudgetService.getLastThreeMonthsTransactions(user.uid);

      // Step 2: Check if sufficient data exists
      if (transactions.length < AppConstants.minTransactionsForAnalysis) {
        await _generateBeginnerBudget(event.monthlyIncome, emit);
        return;
      }

      // Step 3: Analyze spending patterns
      final analysis = _smartBudgetService.analyzeSpendingPatterns(transactions);
      
      final categorySpending = analysis['expensesByCategory'] as Map<String, double>;
      final monthlyAverage = analysis['monthlyAverage'] as Map<String, double>;
      final transactionCount = analysis['transactionCount'] as int;
      final analysisStartDate = analysis['analysisStartDate'] as DateTime;
      final analysisEndDate = analysis['analysisEndDate'] as DateTime;

      // Step 4: Generate AI prompt
      emit(const SmartBudgetState.generating());
      
      final prompt = BudgetAIPrompts.getBudgetAnalysisPrompt(
        monthlyIncome: event.monthlyIncome,
        categorySpending: categorySpending,
        monthlyAverage: monthlyAverage,
        transactionCount: transactionCount,
        analysisStartDate: analysisStartDate,
        analysisEndDate: analysisEndDate,
      );

      // Step 5: Send to AI
      final aiResponse = await _aiService!.sendMessage(prompt);

      // Step 6: Parse AI response
      final budget = await _parseAIBudgetResponse(aiResponse, event.monthlyIncome, user.uid);
      
      emit(budget);
    } catch (e) {
      emit(SmartBudgetState.error(e.toString()));
    }
  }

  Future<void> _generateBeginnerBudget(
    double monthlyIncome,
    Emitter<SmartBudgetState> emit,
  ) async {
    try {
      emit(const SmartBudgetState.generating());

      final prompt = BudgetAIPrompts.getBeginnerBudgetPrompt(monthlyIncome);
      final aiResponse = await _aiService!.sendMessage(prompt);
      
      // Parse beginner response
      final parsed = await _parseBeginnerResponse(aiResponse, monthlyIncome, _firebaseAuth.currentUser!.uid);
      emit(parsed);
    } catch (e) {
      emit(SmartBudgetState.error(e.toString()));
    }
  }

  Future<SmartBudgetState> _parseAIBudgetResponse(
    String response,
    double monthlyIncome,
    String userId,
  ) async {
    try {
      // Extract JSON from response
      String jsonString = response.trim();
      final jsonStart = jsonString.indexOf('{');
      final jsonEnd = jsonString.lastIndexOf('}');
      
      if (jsonStart != -1 && jsonEnd != -1) {
        jsonString = jsonString.substring(jsonStart, jsonEnd + 1);
      }

      final jsonResponse = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Extract data
      final analysis = jsonResponse['analysis'] as String?;
      final recommendations = jsonResponse['recommendations'] as List;
      final tips = (jsonResponse['tips'] as List?)?.cast<String>();

      // Create budget categories
      final categories = recommendations.map((rec) {
        final recMap = rec as Map<String, dynamic>;
        final amount = (recMap['amount'] is int) 
            ? (recMap['amount'] as int).toDouble() 
            : recMap['amount'] as double;
        final percentage = (recMap['percentage'] is int)
            ? (recMap['percentage'] as int).toDouble()
            : recMap['percentage'] as double;
            
        return BudgetCategory(
          name: recMap['category'] as String,
          allocatedAmount: amount,
          allocationPercentage: percentage,
          spentAmount: 0.0,
          availableAmount: amount,
        );
      }).toList();

      // Create budget
      final now = DateTime.now();
      final budget = Budget(
        id: const Uuid().v4(),
        userId: userId,
        monthlyIncome: monthlyIncome,
        categories: categories,
        createdAt: now,
        monthStart: DateTime(now.year, now.month, 1),
      );

      // Create breakdown
      final breakdown = <String, double>{};
      for (var category in categories) {
        breakdown[category.name] = category.allocatedAmount;
      }

      return SmartBudgetState.generated(
        budget: budget,
        breakdown: breakdown,
        analysis: analysis,
        tips: tips,
      );
    } catch (e) {
      // Create user-friendly error message
      String errorMsg;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses analisis budget dari AI. Mohon coba lagi atau ubah sedikit input Anda.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMsg = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda dan coba lagi.';
      } else {
        errorMsg = 'Maaf, terjadi kesalahan saat membuat budget. Silakan coba lagi.';
      }
      throw Exception(errorMsg);
    }
  }

  Future<SmartBudgetState> _parseBeginnerResponse(
    String response,
    double monthlyIncome,
    String userId,
  ) async {
    try {
      // Extract JSON from response
      String jsonString = response.trim();
      final jsonStart = jsonString.indexOf('{');
      final jsonEnd = jsonString.lastIndexOf('}');
      
      if (jsonStart != -1 && jsonEnd != -1) {
        jsonString = jsonString.substring(jsonStart, jsonEnd + 1);
      }

      final jsonResponse = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Extract data
      final welcomeMessage = jsonResponse['welcome_message'] as String;
      final tips = (jsonResponse['tips'] as List).cast<String>();
      final starterBudget = jsonResponse['starter_budget'] as List;

      // Create budget categories
      final categories = starterBudget.map((item) {
        final itemMap = item as Map<String, dynamic>;
        final amount = (itemMap['amount'] is int)
            ? (itemMap['amount'] as int).toDouble()
            : itemMap['amount'] as double;
        final percentage = (itemMap['percentage'] is int)
            ? (itemMap['percentage'] as int).toDouble()
            : itemMap['percentage'] as double;
            
        return BudgetCategory(
          name: itemMap['category'] as String,
          allocatedAmount: amount,
          allocationPercentage: percentage,
          spentAmount: 0.0,
          availableAmount: amount,
        );
      }).toList();

      // Create budget
      final now = DateTime.now();
      final budget = Budget(
        id: const Uuid().v4(),
        userId: userId,
        monthlyIncome: monthlyIncome,
        categories: categories,
        createdAt: now,
        monthStart: DateTime(now.year, now.month, 1),
      );

      return SmartBudgetState.tips(
        welcomeMessage: welcomeMessage,
        tips: tips,
        suggestedBudget: budget,
      );
    } catch (e) {
      // Create user-friendly error message
      String errorMsg;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses saran budget untuk pemula. Mohon coba lagi.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMsg = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda dan coba lagi.';
      } else {
        errorMsg = 'Maaf, terjadi kesalahan saat membuat budget pemula. Silakan coba lagi.';
      }
      throw Exception(errorMsg);
    }
  }

  Future<void> _onApplySmartBudget(
    ApplySmartBudget event,
    Emitter<SmartBudgetState> emit,
  ) async {
    emit(const SmartBudgetState.applying());

    try {
      await _budgetService.saveBudget(event.budget);
      emit(const SmartBudgetState.applied());
    } catch (e) {
      emit(SmartBudgetState.error(e.toString()));
    }
  }

  Future<void> _onRecalculateBudget(
    RecalculateBudget event,
    Emitter<SmartBudgetState> emit,
  ) async {
    // Trigger generation with new income
    add(SmartBudgetEvent.generateSmartBudget(event.newIncome));
  }
}

