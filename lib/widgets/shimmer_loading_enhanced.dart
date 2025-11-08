import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/constants.dart';
import 'glass_card.dart';

/// Shimmer widget factory for consistent skeleton screens
class ShimmerWidget extends StatelessWidget {
  final Widget child;
  
  const ShimmerWidget({
    super.key,
    required this.child,
  });

  Color _getBaseColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.grey[800]! : Colors.grey[300]!;
  }

  Color _getHighlightColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.grey[700]! : Colors.grey[100]!;
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _getBaseColor(context),
      highlightColor: _getHighlightColor(context),
      child: child,
    );
  }
}

/// Box shimmer placeholder with rounded corners
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.sm),
      ),
    );
  }
}

/// Circle shimmer placeholder
class ShimmerCircle extends StatelessWidget {
  final double size;
  final EdgeInsetsGeometry? margin;

  const ShimmerCircle({
    super.key,
    required this.size,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: margin,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Shimmer skeleton for stat cards
class ShimmerStatCard extends StatelessWidget {
  const ShimmerStatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: ShimmerWidget(
        child: Row(
          children: [
            const ShimmerCircle(size: 56),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: 100,
                    height: 14,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ShimmerBox(
                    width: 150,
                    height: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer skeleton for transaction cards
class ShimmerTransactionCard extends StatelessWidget {
  const ShimmerTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: ShimmerWidget(
        child: Row(
          children: [
            ShimmerBox(
              width: 48,
              height: 48,
              borderRadius: AppRadius.md,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: double.infinity,
                    height: 16,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ShimmerBox(
                    width: 120,
                    height: 14,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ShimmerBox(
                    width: 80,
                    height: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            ShimmerBox(
              width: 80,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer skeleton for hero header
class ShimmerHeroHeader extends StatelessWidget {
  final double height;
  
  const ShimmerHeroHeader({
    super.key,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: AppGradients.primary.scale(0.5),
      ),
      child: SafeArea(
        child: ShimmerWidget(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerBox(
                  width: 200,
                  height: 32,
                  borderRadius: AppRadius.md,
                ),
                const SizedBox(height: AppSpacing.sm),
                ShimmerBox(
                  width: 150,
                  height: 16,
                  borderRadius: AppRadius.sm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shimmer skeleton for budget progress card
class ShimmerBudgetCard extends StatelessWidget {
  const ShimmerBudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: ShimmerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ShimmerBox(
                  width: 40,
                  height: 40,
                  borderRadius: AppRadius.sm,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ShimmerBox(
                    height: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerBox(
                  width: 100,
                  height: 20,
                ),
                ShimmerBox(
                  width: 80,
                  height: 14,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ShimmerBox(
              width: double.infinity,
              height: 8,
              borderRadius: AppRadius.sm,
            ),
            const SizedBox(height: AppSpacing.xs),
            ShimmerBox(
              width: 100,
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
} 
