import 'package:firebase_database/firebase_database.dart';
import '../models/budget.dart';
import '../models/transaction.dart' as app_transaction;

class BudgetService {
  static final BudgetService _instance = BudgetService._internal();
  factory BudgetService() => _instance;
  BudgetService._internal();

  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Future<void> saveBudget(Budget budget) async {
    await _db.child('budgets').child(budget.userId).child(budget.id).set({
      'userId': budget.userId,
      'monthlyIncome': budget.monthlyIncome,
      'categories': budget.categories.map((cat) => {
            'name': cat.name,
            'allocationPercentage': cat.allocationPercentage,
            'allocatedAmount': cat.allocatedAmount,
            'spentAmount': cat.spentAmount,
            'availableAmount': cat.availableAmount,
          }).toList(),
      'createdAt': budget.createdAt.millisecondsSinceEpoch,
      'monthStart': budget.monthStart.millisecondsSinceEpoch,
    });
  }

  Future<Budget?> getCurrentMonthBudget(String userId) async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthStartMillis = monthStart.millisecondsSinceEpoch;

    Query query = _db
        .child('budgets')
        .child(userId)
        .orderByChild('monthStart')
        .equalTo(monthStartMillis);

    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;

    if (!snapshot.exists || snapshot.value == null) return null;

    final data = snapshot.value as Map<dynamic, dynamic>;
    if (data.isEmpty) return null;

    final budgetKey = data.keys.first;
    final budgetData = data[budgetKey] as Map<dynamic, dynamic>;

    List<BudgetCategory> categories = (budgetData['categories'] as List<dynamic>).map((catData) {
      return BudgetCategory(
        name: catData['name'],
        allocationPercentage: (catData['allocationPercentage'] as num).toDouble(),
        allocatedAmount: (catData['allocatedAmount'] as num).toDouble(),
        spentAmount: (catData['spentAmount'] as num).toDouble(),
        availableAmount: (catData['availableAmount'] as num).toDouble(),
      );
    }).toList();

    return Budget(
      id: budgetKey,
      userId: budgetData['userId'],
      monthlyIncome: (budgetData['monthlyIncome'] as num).toDouble(),
      categories: categories,
      createdAt: DateTime.fromMillisecondsSinceEpoch(budgetData['createdAt']),
      monthStart: DateTime.fromMillisecondsSinceEpoch(budgetData['monthStart']),
    );
  }

  /// Calculate spent amounts from transactions and update budget
  Future<Budget?> getBudgetWithCalculatedSpending(
    String userId,
    List<app_transaction.Transaction> transactions,
  ) async {
    final budget = await getCurrentMonthBudget(userId);
    if (budget == null) return null;

    // Filter transactions for current month
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final monthTransactions = transactions.where((t) {
      return t.type == 'expense' &&
          t.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
          t.date.isBefore(monthEnd.add(const Duration(days: 1)));
    }).toList();

    // Calculate spent per category
    final spentByCategory = <String, double>{};
    for (final transaction in monthTransactions) {
      spentByCategory[transaction.category] =
          (spentByCategory[transaction.category] ?? 0) + transaction.amount;
    }

    // Update budget categories with actual spending
    final updatedCategories = budget.categories.map((cat) {
      final spent = spentByCategory[cat.name] ?? 0.0;
      return cat.copyWith(
        spentAmount: spent,
        availableAmount: cat.allocatedAmount - spent,
      );
    }).toList();

    return budget.copyWith(categories: updatedCategories);
  }

  Future<void> updateBudgetSpent(String userId, Budget budget) async {
    await _db.child('budgets').child(userId).child(budget.id).set({
      'userId': budget.userId,
      'monthlyIncome': budget.monthlyIncome,
      'categories': budget.categories.map((cat) => {
            'name': cat.name,
            'allocationPercentage': cat.allocationPercentage,
            'allocatedAmount': cat.allocatedAmount,
            'spentAmount': cat.spentAmount,
            'availableAmount': cat.availableAmount,
          }).toList(),
      'createdAt': budget.createdAt.millisecondsSinceEpoch,
      'monthStart': budget.monthStart.millisecondsSinceEpoch,
    });
  }

  Future<void> updateBudget(Budget budget) async {
    await _db.child('budgets').child(budget.userId).child(budget.id).update({
      'userId': budget.userId,
      'monthlyIncome': budget.monthlyIncome,
      'categories': budget.categories.map((cat) => {
            'name': cat.name,
            'allocationPercentage': cat.allocationPercentage,
            'allocatedAmount': cat.allocatedAmount,
            'spentAmount': cat.spentAmount,
            'availableAmount': cat.availableAmount,
          }).toList(),
      'createdAt': budget.createdAt.millisecondsSinceEpoch,
      'monthStart': budget.monthStart.millisecondsSinceEpoch,
    });
  }

  Future<void> deleteBudget(String userId) async {
    final snapshot = await _db.child('budgets').child(userId).get();
    if (snapshot.exists) {
      await _db.child('budgets').child(userId).remove();
    }
  }
  
  /// Check if budget is over limit for alerts
  bool shouldShowBudgetAlert(Budget budget, double threshold) {
    if (budget.monthlyIncome == 0) return false;
    final percentage = budget.totalSpent / budget.monthlyIncome;
    return percentage >= threshold;
  }
  
  /// Get budget alert message
  String getBudgetAlertMessage(Budget budget) {
    final percentage = (budget.totalSpent / budget.monthlyIncome) * 100;
    
    if (budget.remainingBudget < 0) {
      return 'Budget terlampaui! Anda telah menghabiskan ${percentage.toStringAsFixed(0)}% dari budget bulanan.';
    } else if (percentage >= 90) {
      return 'Peringatan: ${percentage.toStringAsFixed(0)}% budget telah terpakai!';
    } else if (percentage >= 80) {
      return 'Perhatian: ${percentage.toStringAsFixed(0)}% budget telah terpakai.';
    }
    
    return '';
  }

  /// Auto-update budget from transactions (recalculate spent and available amounts)
  Future<Budget?> autoUpdateBudgetFromTransactions(
    String userId,
    List<app_transaction.Transaction> transactions,
  ) async {
    final updatedBudget = await getBudgetWithCalculatedSpending(userId, transactions);
    if (updatedBudget != null) {
      // Save updated budget to database
      await updateBudgetSpent(userId, updatedBudget);
    }
    return updatedBudget;
  }
}
