import '../models/budget.dart';
import '../models/transaction.dart' as app_transaction;
import '../utils/constants.dart';

class BudgetAdjustmentService {
  static final BudgetAdjustmentService _instance = BudgetAdjustmentService._internal();
  factory BudgetAdjustmentService() => _instance;
  BudgetAdjustmentService._internal();

  /// Auto-adjust budget allocations based on remaining balance and spending patterns
  /// Combines: updating spent/available amounts + auto-adjusting allocations
  Budget autoAdjustBudgetAllocations({
    required Budget budget,
    required List<app_transaction.Transaction> transactions,
    double adjustmentThreshold = 0.10, // 10% change triggers adjustment
  }) {
    // Step 1: Calculate current month spending
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final monthTransactions = transactions.where((t) {
      return t.type == 'expense' &&
          t.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
          t.date.isBefore(monthEnd.add(const Duration(days: 1)));
    }).toList();

    // Step 2: Update spentAmount and availableAmount for each category
    final spentByCategory = <String, double>{};
    for (final transaction in monthTransactions) {
      spentByCategory[transaction.category] =
          (spentByCategory[transaction.category] ?? 0) + transaction.amount;
    }

    final updatedCategories = budget.categories.map((cat) {
      final spent = spentByCategory[cat.name] ?? 0.0;
      return cat.copyWith(
        spentAmount: spent,
        availableAmount: cat.allocatedAmount - spent,
      );
    }).toList();

    // Step 3: Check if adjustment is needed
    final currentRemainingBalance = budget.monthlyIncome - 
        updatedCategories.fold(0.0, (sum, cat) => sum + cat.spentAmount);
    
    final balanceChange = (budget.monthlyIncome - currentRemainingBalance) / budget.monthlyIncome;
    
    // Step 4: Auto-adjust if threshold exceeded
    if (balanceChange.abs() >= adjustmentThreshold) {
      // Analyze which categories need adjustment
      final adjustedCategories = _calculateAdjustedAllocations(
        budget: budget,
        updatedCategories: updatedCategories,
        currentRemainingBalance: currentRemainingBalance,
      );
      
      return budget.copyWith(categories: adjustedCategories);
    }

    // If no adjustment needed, just return updated spent/available amounts
    return budget.copyWith(categories: updatedCategories);
  }

  /// Calculate adjusted allocations with proportional rebalancing
  List<BudgetCategory> _calculateAdjustedAllocations({
    required Budget budget,
    required List<BudgetCategory> updatedCategories,
    required double currentRemainingBalance,
  }) {
    // Detect categories that are consistently over/under budget
    final overBudgetCategories = <String>{};
    final underBudgetCategories = <String>{};
    
    for (final cat in updatedCategories) {
      if (cat.allocatedAmount > 0) {
        final utilizationRate = cat.spentAmount / cat.allocatedAmount;
        
        if (utilizationRate > 1.2) {
          // Over budget by more than 20%
          overBudgetCategories.add(cat.name);
        } else if (utilizationRate < 0.5 && cat.spentAmount > 0) {
          // Under budget by more than 50% but has spending
          underBudgetCategories.add(cat.name);
        }
      }
    }

    // Calculate adjustment amounts
    final totalOverBudget = updatedCategories
        .where((cat) => overBudgetCategories.contains(cat.name))
        .fold<double>(0, (sum, cat) => sum + (cat.spentAmount - cat.allocatedAmount));
    
    final totalUnderBudget = updatedCategories
        .where((cat) => underBudgetCategories.contains(cat.name))
        .fold<double>(0, (sum, cat) => sum + (cat.allocatedAmount - cat.spentAmount));

    // If there's significant imbalance, redistribute
    if ((totalOverBudget > 0 && totalUnderBudget > 0) || 
        currentRemainingBalance.abs() > budget.monthlyIncome * 0.1) {
      
      return _redistributeAllocations(
        categories: updatedCategories,
        budget: budget,
        overBudgetCategories: overBudgetCategories,
        underBudgetCategories: underBudgetCategories,
      );
    }

    return updatedCategories;
  }

  /// Redistribute allocations proportionally
  List<BudgetCategory> _redistributeAllocations({
    required List<BudgetCategory> categories,
    required Budget budget,
    required Set<String> overBudgetCategories,
    required Set<String> underBudgetCategories,
  }) {
    final adjusted = <BudgetCategory>[];
    double remainingIncome = budget.monthlyIncome;
    
    // Preserve priority: needs > wants > savings
    final categoryType = <String, String>{};
    for (final cat in categories) {
      final type = _getCategoryPriority(cat.name);
      categoryType[cat.name] = type;
    }
    
    // Sort by priority and utilization
    final sortedCategories = List<BudgetCategory>.from(categories)
      ..sort((a, b) {
        final typeA = categoryType[a.name] ?? 'other';
        final typeB = categoryType[b.name] ?? 'other';
        
        // Priority order: needs > wants > savings > other
        final priorityOrder = {'needs': 0, 'wants': 1, 'savings': 2, 'other': 3};
        final priorityCompare = priorityOrder[typeA]!.compareTo(priorityOrder[typeB]!);
        if (priorityCompare != 0) return priorityCompare;
        
        // Within same priority, sort by utilization (higher first for over-budget)
        final utilizationA = a.allocatedAmount > 0 ? a.spentAmount / a.allocatedAmount : 0;
        final utilizationB = b.allocatedAmount > 0 ? b.spentAmount / b.allocatedAmount : 0;
        return utilizationB.compareTo(utilizationA);
      });
    
    // Redistribute: increase allocations for over-budget needs categories
    for (final cat in sortedCategories) {
      final isOverBudget = overBudgetCategories.contains(cat.name);
      final isUnderBudget = underBudgetCategories.contains(cat.name);
      final utilizationRate = cat.allocatedAmount > 0 
          ? cat.spentAmount / cat.allocatedAmount 
          : 0.0;
      
      double newAllocation = cat.allocatedAmount;
      
      if (isOverBudget && cat.spentAmount > 0) {
        // Increase allocation based on actual spending + 10% buffer
        newAllocation = cat.spentAmount * 1.1;
      } else if (isUnderBudget && utilizationRate < 0.3) {
        // Decrease allocation if consistently under-utilized
        newAllocation = cat.allocatedAmount * 0.8;
      }
      
      // Ensure we don't exceed remaining income
      if (newAllocation > remainingIncome * 0.5) {
        newAllocation = remainingIncome * 0.5; // Cap at 50% of remaining
      }
      
      if (newAllocation < 0) newAllocation = 0;
      
      adjusted.add(cat.copyWith(
        allocatedAmount: newAllocation,
        allocationPercentage: budget.monthlyIncome > 0 
            ? newAllocation / budget.monthlyIncome 
            : 0.0,
        availableAmount: newAllocation - cat.spentAmount,
      ));
      
      remainingIncome -= newAllocation;
    }
    
    // Normalize to ensure total equals monthlyIncome
    final totalAllocated = adjusted.fold<double>(0, (sum, cat) => sum + cat.allocatedAmount);
    if (totalAllocated != budget.monthlyIncome) {
      final ratio = budget.monthlyIncome / totalAllocated;
      adjusted.forEach((cat) {
        final newAmount = cat.allocatedAmount * ratio;
        final index = adjusted.indexOf(cat);
        adjusted[index] = cat.copyWith(
          allocatedAmount: newAmount,
          allocationPercentage: budget.monthlyIncome > 0 
              ? newAmount / budget.monthlyIncome 
              : 0.0,
          availableAmount: newAmount - cat.spentAmount,
        );
      });
    }
    
    return adjusted;
  }

  /// Get category priority type
  String _getCategoryPriority(String categoryName) {
    if (['Food', 'Transport', 'Bills', 'Health'].contains(categoryName)) {
      return 'needs';
    } else if (['Shopping', 'Entertainment', 'Other'].contains(categoryName)) {
      return 'wants';
    } else if (['Investment', 'Savings'].contains(categoryName)) {
      return 'savings';
    }
    return 'other';
  }

  /// Get suggested adjustments with reasoning
  Map<String, dynamic> getAdjustmentSuggestions({
    required Budget budget,
    required List<app_transaction.Transaction> transactions,
  }) {
    final adjustedBudget = autoAdjustBudgetAllocations(
      budget: budget,
      transactions: transactions,
    );
    
    final suggestions = <Map<String, dynamic>>[];
    
    for (int i = 0; i < budget.categories.length; i++) {
      final original = budget.categories[i];
      final adjusted = adjustedBudget.categories[i];
      
      if ((adjusted.allocatedAmount - original.allocatedAmount).abs() > 1000) {
        final change = adjusted.allocatedAmount - original.allocatedAmount;
        final changePercent = original.allocatedAmount > 0 
            ? (change / original.allocatedAmount) * 100 
            : 0.0;
        
        suggestions.add({
          'category': original.name,
          'originalAmount': original.allocatedAmount,
          'suggestedAmount': adjusted.allocatedAmount,
          'change': change,
          'changePercent': changePercent,
          'reason': _getAdjustmentReason(original, adjusted),
        });
      }
    }
    
    return {
      'suggestions': suggestions,
      'hasAdjustments': suggestions.isNotEmpty,
    };
  }

  String _getAdjustmentReason(BudgetCategory original, BudgetCategory adjusted) {
    final utilizationRate = original.allocatedAmount > 0 
        ? original.spentAmount / original.allocatedAmount 
        : 0.0;
    
    if (adjusted.allocatedAmount > original.allocatedAmount) {
      if (utilizationRate > 1.0) {
        return 'Pengeluaran melebihi alokasi yang ada';
      } else if (utilizationRate > 0.8) {
        return 'Mendekati batas alokasi';
      }
    } else if (adjusted.allocatedAmount < original.allocatedAmount) {
      if (utilizationRate < 0.3) {
        return 'Alokasi tidak terpakai maksimal';
      }
    }
    
    return 'Penyesuaian berdasarkan pola pengeluaran';
  }
}

