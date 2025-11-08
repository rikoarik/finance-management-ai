import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import 'glass_card.dart';

class BudgetAnalysisCard extends StatelessWidget {
  final Map<String, dynamic> expenseAnalysis;
  final Map<String, dynamic>? incomeAnalysis;
  final Map<String, dynamic>? expenseInsights;
  final Map<String, dynamic>? incomeInsights;
  final bool isLoading;

  const BudgetAnalysisCard({
    super.key,
    required this.expenseAnalysis,
    this.incomeAnalysis,
    this.expenseInsights,
    this.incomeInsights,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return GlassCard(
        child: const Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expense Analysis
        if (expenseInsights != null) ...[
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          gradient: AppGradients.error,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: const Icon(
                          Icons.analytics_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Analisis Pengeluaran',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (expenseInsights?['trend'] != null) ...[
                    _buildInsightItem(
                      context,
                      'Tren',
                      expenseInsights!['trend'] as String,
                      Icons.trending_up_rounded,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  if (expenseInsights?['warnings'] != null &&
                      (expenseInsights!['warnings'] as List).isNotEmpty) ...[
                    ...((expenseInsights!['warnings'] as List)).map((warning) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: AppColors.warning,
                            size: 16,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              warning as String,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  if (expenseInsights?['recommendations'] != null &&
                      (expenseInsights!['recommendations'] as List).isNotEmpty) ...[
                    Text(
                      'Rekomendasi',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ...((expenseInsights!['recommendations'] as List)).map((rec) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_rounded,
                            color: AppColors.info,
                            size: 16,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              rec as String,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        
        // Income Analysis
        if (incomeAnalysis != null && incomeInsights != null) ...[
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          gradient: AppGradients.success,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Analisis Pemasukan',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (incomeInsights?['analysis'] != null) ...[
                    _buildInsightItem(
                      context,
                      'Analisis',
                      incomeInsights!['analysis'] as String,
                      Icons.insights_rounded,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  _buildIncomeStats(context, incomeAnalysis!),
                  if (incomeInsights?['recommendations'] != null &&
                      (incomeInsights!['recommendations'] as List).isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Rekomendasi',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ...((incomeInsights!['recommendations'] as List)).map((rec) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_rounded,
                            color: AppColors.success,
                            size: 16,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              rec as String,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInsightItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeStats(BuildContext context, Map<String, dynamic> incomeAnalysis) {
    final avgIncome = incomeAnalysis['averageMonthlyIncome'] as double? ?? 0.0;
    final currentIncome = incomeAnalysis['currentMonthIncome'] as double? ?? 0.0;
    final isStable = incomeAnalysis['isStable'] as bool? ?? true;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildStatChip(
            context,
            'Rata-rata/Bulan',
            formatCurrency(avgIncome),
            AppColors.info,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildStatChip(
            context,
            'Bulan Ini',
            formatCurrency(currentIncome),
            AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildStatChip(
            context,
            'Stabilitas',
            isStable ? 'Stabil' : 'Berfluktuasi',
            isStable ? AppColors.success : AppColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: AppSpacing.xs / 2),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

