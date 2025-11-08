import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/budget.dart';
import '../models/transaction.dart';
import '../services/database_service.dart';
import '../services/ai_factory.dart';
import '../services/budget_ai_prompts.dart';
import '../utils/constants.dart';

class SmartBudgetService {
  final FirebaseAuth _firebaseAuth;
  final DatabaseService _databaseService;

  SmartBudgetService({
    FirebaseAuth? firebaseAuth,
    DatabaseService? databaseService,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _databaseService = databaseService ?? DatabaseService();

  /// Generate smart budget based on monthly income using 50/30/20 rule
  Budget generateSmartBudget(double monthlyIncome) {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final categories = _calculateCategoryAllocations(monthlyIncome);
    final budgetCategories = categories.entries.map((entry) {
      return BudgetCategory(
        name: entry.key,
        allocationPercentage: entry.value / monthlyIncome,
        allocatedAmount: entry.value,
        spentAmount: 0.0,
        availableAmount: entry.value,
      );
    }).toList();

    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    return Budget(
      id: const Uuid().v4(),
      userId: user.uid,
      monthlyIncome: monthlyIncome,
      categories: budgetCategories,
      createdAt: now,
      monthStart: monthStart,
    );
  }

  /// Calculate category allocations based on 50/30/20 rule
  Map<String, double> _calculateCategoryAllocations(double income) {
    return {
      // Needs (50%)
      'Food': income * 0.20,
      'Transport': income * 0.10,
      'Bills': income * 0.15,
      'Health': income * 0.05,
      
      // Wants (30%)
      'Shopping': income * 0.10,
      'Entertainment': income * 0.10,
      'Other': income * 0.10,
      
      // Savings (20%)
      'Investment': income * 0.15,
      'Savings': income * 0.05,
    };
  }

  /// Get budget recommendations with percentages
  Map<String, double> getBudgetRecommendations() {
    return Map.from(AppConstants.smartBudgetAllocation);
  }

  /// Calculate allocated amount for a category
  double calculateCategoryAmount(double income, double percentage) {
    return income * percentage;
  }

  /// Get category type (needs, wants, savings)
  String getCategoryType(String category) {
    if (['Food', 'Transport', 'Bills', 'Health'].contains(category)) {
      return 'needs';
    } else if (['Shopping', 'Entertainment', 'Other'].contains(category)) {
      return 'wants';
    } else if (['Investment', 'Savings'].contains(category)) {
      return 'savings';
    }
    return 'other';
  }

  /// Get color for category type
  Color getCategoryColor(String category) {
    final type = getCategoryType(category);
    switch (type) {
      case 'needs':
        return AppColors.needsColor;
      case 'wants':
        return AppColors.wantsColor;
      case 'savings':
        return AppColors.savingsColor;
      default:
        return AppColors.grey;
    }
  }

  /// Fetch last 3 months transactions
  Future<List<Transaction>> getLastThreeMonthsTransactions(String userId) async {
    final now = DateTime.now();
    final threeMonthsAgo = DateTime(now.year, now.month - AppConstants.budgetAnalysisMonths, now.day);
    
    return await _databaseService.getTransactionsByDateRange(
      userId: userId,
      startDate: threeMonthsAgo,
      endDate: now,
    );
  }

  /// Analyze spending patterns from transactions
  Map<String, dynamic> analyzeSpendingPatterns(List<Transaction> transactions) {
    final Map<String, double> expensesByCategory = {};
    final Map<String, double> incomeByCategory = {};
    double totalIncome = 0;
    double totalExpense = 0;
    
    for (var transaction in transactions) {
      if (transaction.type == 'expense') {
        expensesByCategory[transaction.category] = 
            (expensesByCategory[transaction.category] ?? 0) + transaction.amount;
        totalExpense += transaction.amount;
      } else if (transaction.type == 'income') {
        incomeByCategory[transaction.category] = 
            (incomeByCategory[transaction.category] ?? 0) + transaction.amount;
        totalIncome += transaction.amount;
      }
    }
    
    // Calculate percentages
    final Map<String, double> categoryPercentages = {};
    if (totalExpense > 0) {
      expensesByCategory.forEach((category, amount) {
        categoryPercentages[category] = amount / totalExpense;
      });
    }
    
    // Calculate monthly averages (over 3 months)
    final Map<String, double> monthlyAverage = {};
    expensesByCategory.forEach((category, amount) {
      monthlyAverage[category] = amount / AppConstants.budgetAnalysisMonths;
    });
    
    // Calculate monthly trends
    final Map<int, double> monthlyTotals = {};
    final Map<String, Map<int, double>> categoryMonthly = {};
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    
    for (var transaction in transactions) {
      if (transaction.type == 'expense') {
        final transactionMonth = DateTime(transaction.date.year, transaction.date.month);
        final monthIndex = _getMonthIndex(currentMonth, transactionMonth);
        
        monthlyTotals[monthIndex] = (monthlyTotals[monthIndex] ?? 0) + transaction.amount;
        
        if (!categoryMonthly.containsKey(transaction.category)) {
          categoryMonthly[transaction.category] = {};
        }
        categoryMonthly[transaction.category]![monthIndex] = 
            (categoryMonthly[transaction.category]![monthIndex] ?? 0) + transaction.amount;
      }
    }
    
    final List<double> monthlyTrends = [];
    for (int i = 0; i < AppConstants.budgetAnalysisMonths; i++) {
      monthlyTrends.add(monthlyTotals[i] ?? 0.0);
    }
    
    final Map<String, List<double>> categoryTrends = {};
    expensesByCategory.keys.forEach((category) {
      final trends = <double>[];
      for (int i = 0; i < AppConstants.budgetAnalysisMonths; i++) {
        trends.add(categoryMonthly[category]?[i] ?? 0.0);
      }
      categoryTrends[category] = trends;
    });
    
    // Calculate spending velocity
    final currentMonthExpenses = transactions
        .where((t) => t.type == 'expense' && 
                     DateTime(t.date.year, t.date.month) == currentMonth)
        .fold<double>(0, (sum, t) => sum + t.amount);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysPassed = now.day;
    final dailySpendingRate = daysPassed > 0 ? currentMonthExpenses / daysPassed : 0.0;
    final projectedMonthlySpending = dailySpendingRate * daysInMonth;
    
    // Top spending categories
    final sortedCategories = expensesByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topSpendingCategories = sortedCategories.take(3).map((e) => e.key).toList();
    
    return {
      'expensesByCategory': expensesByCategory,
      'incomeByCategory': incomeByCategory,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'categoryPercentages': categoryPercentages,
      'monthlyAverage': monthlyAverage,
      'monthlyTrends': monthlyTrends,
      'categoryTrends': categoryTrends,
      'dailySpendingRate': dailySpendingRate,
      'projectedMonthlySpending': projectedMonthlySpending,
      'topSpendingCategories': topSpendingCategories,
      'transactionCount': transactions.length,
      'analysisStartDate': transactions.isNotEmpty 
          ? transactions.last.date 
          : DateTime.now().subtract(const Duration(days: 90)),
      'analysisEndDate': transactions.isNotEmpty 
          ? transactions.first.date 
          : DateTime.now(),
    };
  }

  /// Helper: Get month index (0 = most recent month, 2 = 3 months ago)
  int _getMonthIndex(DateTime currentMonth, DateTime transactionMonth) {
    final diffMonths = (currentMonth.year - transactionMonth.year) * 12 +
                      (currentMonth.month - transactionMonth.month);
    return diffMonths.clamp(0, AppConstants.budgetAnalysisMonths - 1);
  }

  /// Analyze income patterns from transactions
  Map<String, dynamic> analyzeIncomePatterns(List<Transaction> transactions) {
    final Map<String, double> incomeByCategory = {};
    final Map<int, double> monthlyIncomeTotals = {};
    double totalIncome = 0;
    
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    
    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        incomeByCategory[transaction.category] = 
            (incomeByCategory[transaction.category] ?? 0) + transaction.amount;
        totalIncome += transaction.amount;
        
        final transactionMonth = DateTime(transaction.date.year, transaction.date.month);
        final monthIndex = _getMonthIndex(currentMonth, transactionMonth);
        monthlyIncomeTotals[monthIndex] = 
            (monthlyIncomeTotals[monthIndex] ?? 0) + transaction.amount;
      }
    }
    
    final List<double> monthlyIncomeTrends = [];
    for (int i = 0; i < AppConstants.budgetAnalysisMonths; i++) {
      monthlyIncomeTrends.add(monthlyIncomeTotals[i] ?? 0.0);
    }
    
    final currentMonthIncome = transactions
        .where((t) => t.type == 'income' && 
                     DateTime(t.date.year, t.date.month) == currentMonth)
        .fold<double>(0, (sum, t) => sum + t.amount);
    
    final averageMonthlyIncome = totalIncome / AppConstants.budgetAnalysisMonths;
    
    double incomeStability = 0.0;
    if (averageMonthlyIncome > 0 && monthlyIncomeTrends.length > 1) {
      final mean = averageMonthlyIncome;
      final variance = monthlyIncomeTrends
          .map((x) => (x - mean) * (x - mean))
          .fold<double>(0, (sum, x) => sum + x) / monthlyIncomeTrends.length;
      final stdDev = variance > 0 ? sqrt(variance) : 0.0;
      incomeStability = stdDev / mean;
    }
    
    final sortedIncomeSources = incomeByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topIncomeSources = sortedIncomeSources.take(3).map((e) => {
      'category': e.key,
      'amount': e.value,
      'percentage': totalIncome > 0 ? (e.value / totalIncome) : 0.0,
    }).toList();
    
    return {
      'incomeByCategory': incomeByCategory,
      'totalIncome': totalIncome,
      'currentMonthIncome': currentMonthIncome,
      'averageMonthlyIncome': averageMonthlyIncome,
      'monthlyIncomeTrends': monthlyIncomeTrends,
      'incomeStability': incomeStability,
      'topIncomeSources': topIncomeSources,
      'isStable': incomeStability < 0.3,
    };
  }

  /// Generate expense insights using Gemini AI
  Future<Map<String, dynamic>> generateExpenseInsights(
    Map<String, dynamic> expenseAnalysis,
    Budget? currentBudget, {
    double? currentBalance,
    int? daysRemainingInMonth,
  }) async {
    try {
      // Use AIFactory to create Gemini service
      final aiService = AIFactory.createService(
        apiKey: AppConstants.defaultGeminiApiKey,
      );
      
      final prompt = BudgetAIPrompts.getExpenseInsightsPrompt(
        expenseAnalysis: expenseAnalysis,
        currentBudget: currentBudget,
        currentBalance: currentBalance,
        daysRemainingInMonth: daysRemainingInMonth,
      );
      
      final response = await aiService.sendMessage(prompt);
      return _parseInsightsResponse(response);
    } catch (e) {
      // Create user-friendly error message
      String errorMsg;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses analisis pengeluaran. Mohon coba lagi.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMsg = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda.';
      } else {
        errorMsg = 'Maaf, terjadi kesalahan saat menghasilkan analisis. Silakan coba lagi.';
      }
      return {
        'error': errorMsg,
        'trend': 'Tidak dapat dianalisis saat ini',
        'warnings': <String>[],
        'recommendations': <String>[],
      };
    }
  }
  
  /// Generate balance survival analysis using Gemini AI
  Future<Map<String, dynamic>> generateBalanceSurvivalAnalysis({
    required double currentBalance,
    required int daysRemaining,
    required double dailySpendingRate,
    required Map<String, double> categorySpending,
    required Map<String, double> monthlyAverage,
  }) async {
    try {
      // Use AIFactory to create Gemini service
      final aiService = AIFactory.createService(
        apiKey: AppConstants.defaultGeminiApiKey,
      );
      
      final prompt = BudgetAIPrompts.getBalanceSurvivalPrompt(
        currentBalance: currentBalance,
        daysRemaining: daysRemaining,
        dailySpendingRate: dailySpendingRate,
        categorySpending: categorySpending,
        monthlyAverage: monthlyAverage,
      );
      
      final response = await aiService.sendMessage(prompt);
      return _parseInsightsResponse(response);
    } catch (e) {
      // Create user-friendly error message
      String errorMsg;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses analisis survival. Mohon coba lagi.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMsg = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda.';
      } else {
        errorMsg = 'Maaf, terjadi kesalahan saat menganalisis kelangsungan keuangan. Silakan coba lagi.';
      }
      return {
        'error': errorMsg,
        'survival_analysis': 'Tidak dapat dianalisis saat ini',
        'can_survive': false,
        'category_recommendations': <Map<String, dynamic>>[],
      };
    }
  }

  /// Generate income insights using Gemini AI
  Future<Map<String, dynamic>> generateIncomeInsights(
    Map<String, dynamic> incomeAnalysis,
    Map<String, dynamic> expenseAnalysis,
  ) async {
    try {
      // Use AIFactory to create Gemini service
      final aiService = AIFactory.createService(
        apiKey: AppConstants.defaultGeminiApiKey,
      );
      
      final prompt = BudgetAIPrompts.getIncomeInsightsPrompt(
        incomeAnalysis: incomeAnalysis,
        expenseAnalysis: expenseAnalysis,
      );
      
      final response = await aiService.sendMessage(prompt);
      return _parseInsightsResponse(response);
    } catch (e) {
      // Create user-friendly error message
      String errorMsg;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses analisis pendapatan. Mohon coba lagi.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMsg = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda.';
      } else {
        errorMsg = 'Maaf, terjadi kesalahan saat menghasilkan analisis pendapatan. Silakan coba lagi.';
      }
      return {
        'error': errorMsg,
        'analysis': 'Tidak dapat dianalisis saat ini',
        'recommendations': <String>[],
        'savingsPotential': 0.0,
      };
    }
  }

  /// Parse AI insights response (JSON)
  Map<String, dynamic> _parseInsightsResponse(String response) {
    try {
      String jsonString = response.trim();
      final jsonStart = jsonString.indexOf('{');
      final jsonEnd = jsonString.lastIndexOf('}');
      
      if (jsonStart != -1 && jsonEnd != -1) {
        jsonString = jsonString.substring(jsonStart, jsonEnd + 1);
      }

      final jsonResponse = jsonDecode(jsonString) as Map<String, dynamic>;
      return jsonResponse;
    } catch (e) {
      // Create user-friendly error message
      String errorMsg;
      if (e.toString().contains('parse') || e.toString().contains('JSON')) {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses analisis. Mohon coba lagi.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMsg = 'Sepertinya ada masalah dengan koneksi internet. Mohon periksa koneksi Anda.';
      } else {
        errorMsg = 'Maaf, terjadi kesalahan saat memproses data. Silakan coba lagi.';
      }
      return {'error': errorMsg};
    }
  }
}

