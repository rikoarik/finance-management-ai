import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/budget.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/helpers.dart';

class BudgetOverviewCard extends StatelessWidget {
  final Budget budget;
  final VoidCallback? onTap;
  
  const BudgetOverviewCard({
    super.key,
    required this.budget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = budget.monthlyIncome > 0
        ? (budget.totalSpent / budget.monthlyIncome) * 100
        : 0.0;
    final color = Helpers.getBudgetStatusColor(budget.totalSpent, budget.monthlyIncome);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Budget Bulan Ini',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Helpers.getBudgetStatusIcon(budget.totalSpent, budget.monthlyIncome),
                    color: color,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Donut Chart
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            startDegreeOffset: 270,
                            sectionsSpace: 2,
                            centerSpaceRadius: 35,
                            sections: [
                              PieChartSectionData(
                                value: budget.totalSpent,
                                color: color,
                                radius: 15,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: budget.remainingBudget > 0 ? budget.remainingBudget : 0,
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                radius: 15,
                                showTitle: false,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                            Text(
                              'Terpakai',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          context,
                          'Total Budget',
                          Formatters.currency(budget.monthlyIncome),
                          AppColors.primary,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildInfoRow(
                          context,
                          'Terpakai',
                          Formatters.currency(budget.totalSpent),
                          AppColors.expense,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildInfoRow(
                          context,
                          'Sisa',
                          Formatters.currency(budget.remainingBudget),
                          budget.remainingBudget >= 0 ? AppColors.success : AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Daily Budget
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budget Harian',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          Formatters.currency(budget.dailyBudget),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Budget Mingguan',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          Formatters.currency(budget.weeklyBudget),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Warning if over budget
              if (budget.remainingBudget < 0) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: AppColors.error, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Anda telah melebihi budget sebesar ${Formatters.currency(budget.remainingBudget.abs())}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (percentage >= 90) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info, color: AppColors.warning, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Hampir mencapai limit budget! Sisa ${Formatters.currency(budget.remainingBudget)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(BuildContext context, String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class BudgetCategoryCard extends StatelessWidget {
  final BudgetCategory category;
  
  const BudgetCategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = category.allocatedAmount > 0
        ? (category.spentAmount / category.allocatedAmount)
        : 0.0;
    final color = Helpers.getBudgetStatusColor(category.spentAmount, category.allocatedAmount);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(percentage * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: LinearProgressIndicator(
                value: percentage.clamp(0.0, 1.0),
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                valueColor: AlwaysStoppedAnimation(color),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terpakai: ${Formatters.currency(category.spentAmount)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Sisa: ${Formatters.currency(category.availableAmount)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: category.availableAmount >= 0 ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

