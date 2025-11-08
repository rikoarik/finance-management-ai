class BudgetCategory {
  final String name;
  final double allocationPercentage; // 0.0 to 1.0
  final double allocatedAmount; // Monthly allocated amount
  final double spentAmount; // Actual spent this month
  final double availableAmount; // Remaining for spending

  BudgetCategory({
    required this.name,
    required this.allocationPercentage,
    required this.allocatedAmount,
    required this.spentAmount,
    required this.availableAmount,
  });

  BudgetCategory copyWith({
    String? name,
    double? allocationPercentage,
    double? allocatedAmount,
    double? spentAmount,
    double? availableAmount,
  }) {
    return BudgetCategory(
      name: name ?? this.name,
      allocationPercentage: allocationPercentage ?? this.allocationPercentage,
      allocatedAmount: allocatedAmount ?? this.allocatedAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      availableAmount: availableAmount ?? this.availableAmount,
    );
  }
}

class Budget {
  final String id;
  final String userId;
  final double monthlyIncome;
  final List<BudgetCategory> categories;
  final DateTime createdAt;
  final DateTime monthStart; // First day of current month

  Budget({
    required this.id,
    required this.userId,
    required this.monthlyIncome,
    required this.categories,
    required this.createdAt,
    required this.monthStart,
  });

  double get totalSpent => categories.fold(0, (sum, cat) => sum + cat.spentAmount);
  double get remainingBudget => monthlyIncome - totalSpent;
  double get totalAllocation => categories.fold(0, (sum, cat) => sum + cat.allocatedAmount);

  // Calculate daily budget for remaining month
  double get dailyBudget {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysRemaining = daysInMonth - now.day + 1;
    return remainingBudget / daysRemaining;
  }

  // Weekly budget for remaining month
  double get weeklyBudget => dailyBudget * 7;

  Budget copyWith({
    String? id,
    String? userId,
    double? monthlyIncome,
    List<BudgetCategory>? categories,
    DateTime? createdAt,
    DateTime? monthStart,
  }) {
    return Budget(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      monthStart: monthStart ?? this.monthStart,
    );
  }
}
