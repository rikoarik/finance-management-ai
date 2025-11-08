import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'animated_counter.dart';
import 'glass_card.dart';

/// Modern metric display card with icon and optional trend
class StatCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color? color;
  final Gradient? gradient;
  final bool isCurrency;
  final String? subtitle;
  final double? trend;
  final VoidCallback? onTap;
  final Widget? trailing;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.gradient,
    this.isCurrency = true,
    this.subtitle,
    this.trend,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;

    return RepaintBoundary(
      child: GlassCard(
        onTap: onTap,
        child: Row(
        children: [
          // Icon container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      effectiveColor,
                      effectiveColor.withOpacity(0.7),
                    ],
                  ),
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: effectiveColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          
          const SizedBox(width: AppSpacing.md),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Flexible(
                      child: AnimatedCounter(
                        value: value,
                        isCurrency: isCurrency,
                        textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    if (trend != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      _TrendBadge(trend: trend!),
                    ],
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
        ),
      ),
    );
  }
}

/// Compact stat card for grid layouts
class CompactStatCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color? color;
  final bool isCurrency;
  final VoidCallback? onTap;

  const CompactStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.isCurrency = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: effectiveColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  icon,
                  color: effectiveColor,
                  size: 20,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          AnimatedCounter(
            value: value,
            isCurrency: isCurrency,
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat card with progress indicator
class ProgressStatCard extends StatelessWidget {
  final String title;
  final double current;
  final double target;
  final IconData icon;
  final Color? color;
  final bool isCurrency;
  final VoidCallback? onTap;

  const ProgressStatCard({
    super.key,
    required this.title,
    required this.current,
    required this.target,
    required this.icon,
    this.color,
    this.isCurrency = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final isOverBudget = current > target;

    return GlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      effectiveColor,
                      effectiveColor.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedCounter(
                value: current,
                isCurrency: isCurrency,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isOverBudget ? AppColors.error : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                '/ ${isCurrency ? "Rp${target.toStringAsFixed(0)}" : target.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.sm),
          
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(context).dividerColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverBudget ? AppColors.error : effectiveColor,
              ),
              minHeight: 8,
            ),
          ),
          
          const SizedBox(height: AppSpacing.xs),
          
          Text(
            '${(progress * 100).toStringAsFixed(0)}% ${isOverBudget ? "melebihi" : "terpakai"}',
            style: TextStyle(
              fontSize: 12,
              color: isOverBudget 
                  ? AppColors.error 
                  : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Trend badge for showing percentage changes
class _TrendBadge extends StatelessWidget {
  final double trend;

  const _TrendBadge({required this.trend});

  @override
  Widget build(BuildContext context) {
    final isPositive = trend >= 0;
    final color = isPositive ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 2),
          Text(
            '${trend.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple stat card without icon
class SimpleStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Color? color;
  final VoidCallback? onTap;

  const SimpleStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
