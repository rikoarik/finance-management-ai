import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/chat_message.dart';
import '../../models/transaction.dart' as app_transaction;
import '../../models/budget.dart';
import '../../services/ai_factory.dart';
import '../../services/ai_service_interface.dart';
import '../../services/database_service.dart';
import '../../services/budget_service.dart';
import '../../services/file_processing_service.dart';
import '../../services/firebase_config_service.dart';
import '../../services/subscription_service.dart';
import '../../exceptions/quota_exceeded_exception.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DatabaseService _databaseService;
  final BudgetService _budgetService;
  final FirebaseAuth _firebaseAuth;
  final FirebaseConfigService _firebaseConfigService;
  final SubscriptionService _subscriptionService;
  AIService? _aiService;
  CancelableOperation? _currentAiRequest;

  ChatBloc({
    DatabaseService? databaseService,
    BudgetService? budgetService,
    FirebaseAuth? firebaseAuth,
    FirebaseConfigService? firebaseConfigService,
    SubscriptionService? subscriptionService,
  })  : _databaseService = databaseService ?? DatabaseService(),
        _budgetService = budgetService ?? BudgetService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseConfigService = firebaseConfigService ?? FirebaseConfigService(),
        _subscriptionService = subscriptionService ?? SubscriptionService(),
        super(_getInitialState(firebaseAuth ?? FirebaseAuth.instance)) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<ConfirmTransaction>(_onConfirmTransaction);
    on<CancelTransaction>(_onCancelTransaction);
    on<ClearChat>(_onClearChat);
    on<DismissUpgradeDialog>(_onDismissUpgradeDialog);
  }
  
  static ChatState _getInitialState(FirebaseAuth firebaseAuth) {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      // Langsung return loaded dengan welcome message tanpa delay
      final welcomeMessage = ChatMessage(
        id: 'welcome',
        userId: user.uid,
        message: 'Halo! Saya asisten keuangan Anda. Anda bisa mencatat transaksi dengan bahasa natural, misalnya "Beli makan 50 ribu".',
        isUser: false,
        timestamp: DateTime.now(),
      );
      return ChatState.loaded(messages: [welcomeMessage]);
    }
    return const ChatState.initial();
  }

  Future<void> initializeAI() async {
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
      print('Error initializing AI: $e');
      _aiService = null;
    }
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      // If no user, emit loaded with empty messages instead of staying in initial
      emit(const ChatState.loaded(messages: []));
      return Future.value();
    }

    // Load with welcome message - langsung emit tanpa delay (synchronous)
    final welcomeMessage = ChatMessage(
      id: 'welcome',
      userId: user.uid,
      message: 'Halo! Saya asisten keuangan Anda. Anda bisa mencatat transaksi dengan bahasa natural, misalnya "Beli makan 50 ribu".',
      isUser: false,
      timestamp: DateTime.now(),
    );

    emit(ChatState.loaded(messages: [welcomeMessage]));
    return Future.value();
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;
    
    if (_aiService == null) {
      emit(const ChatState.error('AI service belum dikonfigurasi. Silakan cek pengaturan.'));
      return;
    }

    // Check trial/subscription status
    final canUseAI = await _subscriptionService.canUseAI(user.uid);
    if (!canUseAI) {
      // Try to start trial if not started yet
      final isTrialActive = await _subscriptionService.isTrialActive(user.uid);
      if (!isTrialActive) {
        try {
          // Get device ID and check if can start trial
          final deviceId = await _subscriptionService.getDeviceId();
          final canStart = await _subscriptionService.canStartTrial(user.uid, deviceId);
          
          if (canStart) {
            await _subscriptionService.startTrial(user.uid, deviceId);
          } else {
            // Device already used trial, show upgrade dialog
            if (state is ChatLoaded) {
              final currentState = state as ChatLoaded;
              emit(currentState.copyWith(showUpgradeDialog: true));
            }
            return;
          }
        } catch (e) {
          // If starting trial fails, show upgrade dialog
          if (state is ChatLoaded) {
            final currentState = state as ChatLoaded;
            emit(currentState.copyWith(showUpgradeDialog: true));
          }
          return;
        }
      } else {
        // Trial expired, show upgrade dialog
        if (state is ChatLoaded) {
          final currentState = state as ChatLoaded;
          emit(currentState.copyWith(showUpgradeDialog: true));
        }
        return;
      }
    }

    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Add user message (optimistic) with file attachment if any
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: user.uid,
      message: event.message,
      isUser: true,
      timestamp: DateTime.now(),
      filePath: event.filePath,
      fileName: event.fileName,
      fileType: event.fileType,
    );

    emit(currentState.copyWith(
      messages: [...currentState.messages, userMessage],
      isAiTyping: true,
    ));

    try {
      // Cancel previous AI request if exists
      _currentAiRequest?.cancel();

      final systemPrompt = AIFactory.getFinancialPrompt();
      
      // Process file if exists
      String? extractedFileContent;
      String? imagePath;
      String? documentPath;
      
      if (event.filePath != null && event.fileType != null) {
        final file = File(event.filePath!);
        if (await file.exists()) {
          if (event.fileType == 'image') {
            // For images, pass path directly for Gemini vision API
            // For other AI services, still need text extraction
            imagePath = event.filePath;
            
            // Gemini handles images directly via vision API, no text extraction needed
          } else if (event.fileType == 'document') {
            documentPath = event.filePath;
            // Extract text from document
            extractedFileContent = await FileProcessingService.extractTextFromFile(
              file: file,
              fileType: event.fileType!,
            );
          }
        }
      }
      
      // Prepare message with file content
      final messageToSend = event.message.isEmpty 
          ? (event.fileType == 'image' 
              ? 'Analisa struk atau dokumen dalam gambar ini dan ekstrak informasi transaksi pengeluaran. Identifikasi total, kategori, dan deskripsi transaksi.' 
              : 'Analisa dokumen ini dan ekstrak informasi transaksi pengeluaran. Identifikasi total, kategori, dan deskripsi transaksi.')
          : event.message;
      
      // Create cancelable operation
      _currentAiRequest = CancelableOperation.fromFuture(
        _aiService!.sendMessageWithFile(
          messageToSend,
          extractedFileContent: extractedFileContent,
          systemPrompt: systemPrompt,
          imagePath: imagePath,
          documentPath: documentPath,
        ),
      );

      final response = await _currentAiRequest!.value;

      // Try to parse as transaction or budget suggestion
      Map<String, dynamic>? transactionData;
      String displayMessage = response;

      print('======= AI RESPONSE RECEIVED =======');
      print('Response: $response');
      print('====================================');

      try {
        // Try to extract JSON from response (AI might add text before/after)
        String jsonString = response.trim();
        
        // Find JSON object or array in response
        final jsonStart = jsonString.indexOf('{');
        final jsonEnd = jsonString.lastIndexOf('}');
        final arrayStart = jsonString.indexOf('[');
        final arrayEnd = jsonString.lastIndexOf(']');
        
        // Try to extract JSON object first
        if (jsonStart != -1 && jsonEnd != -1 && jsonEnd > jsonStart) {
          jsonString = jsonString.substring(jsonStart, jsonEnd + 1);
        }
        // If no object, try array
        else if (arrayStart != -1 && arrayEnd != -1 && arrayEnd > arrayStart) {
          jsonString = jsonString.substring(arrayStart, arrayEnd + 1);
        }
        
        dynamic jsonResponse = jsonDecode(jsonString);
        
        // Handle case where response is array directly
        if (jsonResponse is List) {
          final transactions = jsonResponse;
          
          // Normalize amounts in all transactions
          final validTransactions = <Map<String, dynamic>>[];
          for (var i = 0; i < transactions.length; i++) {
            final trans = transactions[i] as Map<String, dynamic>;
            
            // Skip if action is null or not a string
            if (trans['action'] == null || trans['action'] is! String) {
              print('Warning: Transaction $i has invalid action: ${trans['action']}, skipping');
              continue;
            }
            
            // Skip if amount is null or cannot be converted to number
            if (trans['amount'] == null) {
              print('Warning: Transaction $i has null amount, skipping');
              continue;
            }
            
            if (trans['amount'] is String) {
              trans['amount'] = double.parse(trans['amount'].toString().replaceAll(RegExp(r'[^\d.]'), ''));
            } else if (trans['amount'] is int) {
              trans['amount'] = (trans['amount'] as int).toDouble();
            } else if (trans['amount'] is double) {
              // Already double
            } else {
              print('Warning: Transaction $i has invalid amount type, skipping');
              continue;
            }
            
            trans['category'] = (trans['category'] ?? 'Other').toString();
            trans['note'] = (trans['note'] ?? '').toString();
            
            validTransactions.add(trans);
          }
          
          if (validTransactions.isEmpty) {
            throw Exception('No valid transactions found in array');
          }
          
          transactionData = {
            'multiple': true,
            'transactions': validTransactions,
          };
          displayMessage = _generateMultipleTransactionMessage(validTransactions);
        }
        // Handle case where response is object
        else if (jsonResponse is Map) {
          // Check for multiple transactions
          if (jsonResponse.containsKey('transactions')) {
            final transactions = jsonResponse['transactions'] as List;
            
            // Validate and normalize amounts in all transactions
            final validTransactions = <Map<String, dynamic>>[];
            for (var i = 0; i < transactions.length; i++) {
              final trans = transactions[i] as Map<String, dynamic>;
              
              // Ensure action exists and is a string
              if (!trans.containsKey('action') || trans['action'] == null || trans['action'] is! String) {
                print('Warning: Transaction $i has invalid action: ${trans['action']}, skipping');
                continue;
              }
              
              // Ensure amount exists and is not null
              if (!trans.containsKey('amount') || trans['amount'] == null) {
                print('Warning: Transaction $i missing amount, skipping');
                continue;
              }
              
              // Normalize amount
              if (trans['amount'] is String) {
                trans['amount'] = double.parse(trans['amount'].toString().replaceAll(RegExp(r'[^\d.]'), ''));
              } else if (trans['amount'] is int) {
                trans['amount'] = (trans['amount'] as int).toDouble();
              } else if (trans['amount'] is double) {
                // Already double, no conversion needed
              } else {
                print('Warning: Transaction $i has invalid amount type: ${trans['amount'].runtimeType}, skipping');
                continue;
              }
              
              // Ensure category and note exist (convert to String)
              trans['category'] = (trans['category'] ?? 'Other').toString();
              trans['note'] = (trans['note'] ?? '').toString();
              
              validTransactions.add(trans);
            }
            
            if (validTransactions.isEmpty) {
              throw Exception('No valid transactions found');
            }
            
            transactionData = {
              'multiple': true,
              'transactions': validTransactions,
            };
            displayMessage = _generateMultipleTransactionMessage(validTransactions);
          }
          // Check for single transaction
          else if (jsonResponse.containsKey('action')) {
            transactionData = Map<String, dynamic>.from(jsonResponse);
            
            // Ensure amount is a number
            if (transactionData['amount'] is String) {
              transactionData['amount'] = double.parse(transactionData['amount'].toString().replaceAll(RegExp(r'[^\d.]'), ''));
            } else if (transactionData['amount'] is int) {
              transactionData['amount'] = (transactionData['amount'] as int).toDouble();
            }
            
            // Ensure category and note exist
            transactionData['category'] = transactionData['category'] ?? 'Other';
            transactionData['note'] = transactionData['note'] ?? '';
            
            if (transactionData['action'] == 'suggest_budget') {
              displayMessage = _generateBudgetMessage(transactionData);
            } else {
              displayMessage = _generateTransactionMessage(transactionData);
            }
          }
        }
      } catch (e) {
        // Log error for debugging, but continue with regular message
        print('======= ERROR PARSING JSON =======');
        print('Error: $e');
        print('Full AI Response:');
        print(response);
        print('==================================');
        // Not JSON, just regular message - transactionData remains null
        // The response will be shown as regular chat message, which is fine
      }

      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.uid,
        message: displayMessage,
        isUser: false,
        timestamp: DateTime.now(),
        transactionData: transactionData,
      );

      if (state is ChatLoaded) {
        final updatedState = state as ChatLoaded;
        emit(updatedState.copyWith(
          messages: [...updatedState.messages, aiMessage],
          pendingTransaction: transactionData,
          isAiTyping: false,
          showUpgradeDialog: false,
        ));
      }
    } catch (e) {
      if (e is CancelledException) {
        return;
      }
      
      // Handle quota exceeded exception
      if (e is QuotaExceededException) {
        if (state is ChatLoaded) {
          final updatedState = state as ChatLoaded;
          emit(updatedState.copyWith(
            isAiTyping: false,
            showUpgradeDialog: true,
          ));
        }
        return;
      }
      
      // Create user-friendly error message
      String friendlyErrorMessage;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        friendlyErrorMessage = 'Maaf, saya mengalami kesulitan memproses respons. Mohon coba lagi atau tanyakan dengan cara yang berbeda.';
      } else if (e.toString().contains('network') || e.toString().contains('connection') || e.toString().contains('timeout')) {
        friendlyErrorMessage = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda dan coba lagi.';
      } else if (e.toString().contains('quota') || e.toString().contains('limit')) {
        friendlyErrorMessage = 'Limit penggunaan AI telah tercapai. Silakan upgrade ke premium untuk melanjutkan.';
      } else {
        friendlyErrorMessage = 'Maaf, terjadi kesalahan saat memproses permintaan Anda. Silakan coba lagi.';
      }
      
      final errorMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.uid,
        message: friendlyErrorMessage,
        isUser: false,
        timestamp: DateTime.now(),
      );

      if (state is ChatLoaded) {
        final updatedState = state as ChatLoaded;
        emit(updatedState.copyWith(
          messages: [...updatedState.messages, errorMessage],
          isAiTyping: false,
          showUpgradeDialog: false,
        ));
      }
    }
  }

  String _generateTransactionMessage(Map<String, dynamic> data) {
    final action = data['action'] as String? ?? 'record_expense';
    final type = action == 'record_income' ? 'pemasukan' : 'pengeluaran';
    final amount = (data['amount'] as num?)?.toDouble() ?? 0.0;
    final category = data['category'] as String? ?? 'Other';
    final note = data['note'] as String? ?? '';

    return 'Saya mendeteksi $type sebesar Rp${amount.toStringAsFixed(0)} dalam kategori $category${note.isNotEmpty ? ' dengan catatan "$note"' : ''}. Apakah Anda ingin menyimpan transaksi ini?';
  }

  String _generateMultipleTransactionMessage(List transactions) {
    final buffer = StringBuffer('Saya mendeteksi ${transactions.length} transaksi:\n\n');
    
    double totalIncome = 0;
    double totalExpense = 0;
    
    for (var i = 0; i < transactions.length; i++) {
      final trans = transactions[i] as Map<String, dynamic>;
      final action = trans['action'] as String? ?? 'record_expense';
      final amount = (trans['amount'] as num?)?.toDouble() ?? 0.0;
      final category = trans['category'] as String? ?? 'Other';
      final note = trans['note'] as String? ?? '';
      final type = action == 'record_income' ? 'Pemasukan' : 'Pengeluaran';
      
      if (action == 'record_income') {
        totalIncome += amount;
      } else {
        totalExpense += amount;
      }
      
      buffer.write('${i + 1}. [$type] ${note.isNotEmpty ? note : category} - Rp${amount.toStringAsFixed(0)}\n');
    }
    
    if (totalIncome > 0 && totalExpense > 0) {
      buffer.write('\nTotal Pemasukan: Rp${totalIncome.toStringAsFixed(0)}');
      buffer.write('\nTotal Pengeluaran: Rp${totalExpense.toStringAsFixed(0)}');
      buffer.write('\n\n');
    } else {
      final total = totalIncome > 0 ? totalIncome : totalExpense;
      buffer.write('\nTotal: Rp${total.toStringAsFixed(0)}\n\n');
    }
    buffer.write('Apakah Anda ingin menyimpan semua transaksi ini?');
    
    return buffer.toString();
  }

  String _generateBudgetMessage(Map<String, dynamic> data) {
    return data['message'] ?? 'Saya telah menyiapkan saran budget untuk Anda.';
  }

  Future<void> _onConfirmTransaction(
    ConfirmTransaction event,
    Emitter<ChatState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    try {
      // Check if multiple transactions
      if (event.transactionData['multiple'] == true) {
        final transactions = event.transactionData['transactions'] as List;
        
        for (var trans in transactions) {
          await _saveTransaction(user.uid, trans as Map<String, dynamic>);
        }
        
        final confirmMessage = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: user.uid,
          message: '✓ ${transactions.length} transaksi berhasil disimpan!',
          isUser: false,
          timestamp: DateTime.now(),
        );

        emit(currentState.copyWith(
          messages: [...currentState.messages, confirmMessage],
          pendingTransaction: null,
        ));
      } else {
        // Single transaction
        final action = event.transactionData['action'];

        if (action == 'suggest_budget') {
          await _saveBudgetSuggestion(user.uid, event.transactionData);
        } else {
          await _saveTransaction(user.uid, event.transactionData);
        }

        final confirmMessage = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: user.uid,
          message: action == 'suggest_budget' 
              ? 'Budget berhasil dibuat! ✓'
              : 'Transaksi berhasil disimpan! ✓',
          isUser: false,
          timestamp: DateTime.now(),
        );

        emit(currentState.copyWith(
          messages: [...currentState.messages, confirmMessage],
          pendingTransaction: null,
        ));
      }
    } catch (e) {
      emit(ChatState.error(e.toString()));
    }
  }

  Future<void> _saveTransaction(String userId, Map<String, dynamic> data) async {
    final action = data['action'] as String? ?? 'record_expense';
    final amount = (data['amount'] as num?)?.toDouble() ?? 0.0;
    final category = data['category'] as String? ?? 'Other';
    final note = data['note'] as String? ?? '';
    
    final transaction = app_transaction.Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      type: action == 'record_income' ? 'income' : 'expense',
      amount: amount,
      category: category,
      date: DateTime.now(),
      note: note,
    );

    await _databaseService.addTransaction(transaction);
  }

  Future<void> _saveBudgetSuggestion(String userId, Map<String, dynamic> data) async {
    final totalBudget = (data['amount'] as num).toDouble();
    final categories = data['categories'] as Map<String, dynamic>?;

    if (categories == null) {
      throw Exception('No category suggestions provided');
    }

    final budgetCategories = categories.entries.map((entry) {
      final allocatedAmount = (entry.value as num).toDouble();
      return BudgetCategory(
        name: entry.key,
        allocationPercentage: allocatedAmount / totalBudget,
        allocatedAmount: allocatedAmount,
        spentAmount: 0.0,
        availableAmount: allocatedAmount,
      );
    }).toList();

    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    final budget = Budget(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      monthlyIncome: totalBudget,
      categories: budgetCategories,
      createdAt: now,
      monthStart: monthStart,
    );

    await _budgetService.saveBudget(budget);
  }

  Future<void> _onCancelTransaction(
    CancelTransaction event,
    Emitter<ChatState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    final cancelMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: user.uid,
      message: 'Baik, dibatalkan. Ada yang bisa saya bantu lagi?',
      isUser: false,
      timestamp: DateTime.now(),
    );

    emit(currentState.copyWith(
      messages: [...currentState.messages, cancelMessage],
      pendingTransaction: null,
    ));
  }

  Future<void> _onClearChat(ClearChat event, Emitter<ChatState> emit) async {
    add(const LoadMessages());
  }

  /// Reset upgrade dialog flag
  void dismissUpgradeDialog() {
    add(const ChatEvent.dismissUpgradeDialog());
  }

  Future<void> _onDismissUpgradeDialog(
    DismissUpgradeDialog event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(showUpgradeDialog: false));
    }
  }

  @override
  Future<void> close() {
    _currentAiRequest?.cancel();
    return super.close();
  }
}

// Simple cancelable operation
class CancelableOperation<T> {
  final Future<T> _future;
  bool _isCanceled = false;

  CancelableOperation.fromFuture(this._future);

  Future<T> get value async {
    final result = await _future;
    if (_isCanceled) {
      throw CancelledException();
    }
    return result;
  }

  void cancel() {
    _isCanceled = true;
  }
}

class CancelledException implements Exception {}

