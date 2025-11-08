import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import 'glass_card.dart';

class BudgetStatusWidget extends StatelessWidget {
  final Budget budget;
  final VoidCallback? onRefresh;

  const BudgetStatusWidget({
    super.key,
    required this.budget,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final remainingBalance = budget.remainingBudget;
    final totalSpent = budget.totalSpent;
    final spendingPercentage = budget.monthlyIncome > 0 
        ? (totalSpent / budget.monthlyIncome) * 100 
        : 0.0;

    final isWarning = spendingPercentage >= 80;
    final isDanger = spendingPercentage >= 90;
    
    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with refresh button
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: isDanger 
                      ? AppGradients.error 
                      : isWarning 
                          ? AppGradients.warning 
                          : AppGradients.success,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  isDanger 
                      ? Icons.warning_rounded 
                      : isWarning 
                          ? Icons.info_outline_rounded 
                          : Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Status Budget',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (onRefresh != null)
                IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: onRefresh,
                  tooltip: 'Refresh',
                  iconSize: 20,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Remaining Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Tersisa',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    formatCurrency(remainingBalance),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDanger 
                          ? AppColors.error 
                          : isWarning 
                              ? AppColors.warning 
                              : AppColors.success,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Terpakai',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${spendingPercentage.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDanger 
                          ? AppColors.error 
                          : isWarning 
                              ? AppColors.warning 
                              : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: LinearProgressIndicator(
              value: spendingPercentage / 100,
              minHeight: 10,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                isDanger 
                    ? AppColors.error 
                    : isWarning 
                        ? AppColors.warning 
                        : AppColors.success,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          
          // Summary Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                context,
                'Pendapatan',
                    formatCurrency(budget.monthlyIncome),
                AppColors.success,
              ),
              _buildStatItem(
                context,
                'Terpakai',
                    formatCurrency(totalSpent),
                AppColors.textSecondary,
              ),
              _buildStatItem(
                context,
                'Sisa',
                    formatCurrency(remainingBalance),
                remainingBalance > 0 ? AppColors.success : AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: AppSpacing.xs / 2),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

