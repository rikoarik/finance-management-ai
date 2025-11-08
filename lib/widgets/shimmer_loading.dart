import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/constants.dart';
import 'glass_card.dart';

/// Shimmer loading untuk list items dengan modern skeleton
class ShimmerListLoading extends StatelessWidget {
  final int itemCount;
  final bool useGlassCard;
  
  const ShimmerListLoading({
    super.key,
    this.itemCount = 5,
    this.useGlassCard = true,
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
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final shimmerChild = Shimmer.fromColors(
          baseColor: _getBaseColor(context),
          highlightColor: _getHighlightColor(context),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Icon placeholder with rounded corners
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                
                // Content placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with rounded corners
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Subtitle with rounded corners
                      Container(
                        width: 150,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Amount placeholder
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ],
            ),
          ),
        );

        if (useGlassCard) {
          return GlassCard(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            padding: EdgeInsets.zero,
            child: shimmerChild,
          );
        }

        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          child: shimmerChild,
        );
      },
    );
  }
}

/// Shimmer loading untuk cards dengan modern skeleton
class ShimmerCardLoading extends StatelessWidget {
  final bool useGlassCard;
  
  const ShimmerCardLoading({
    super.key,
    this.useGlassCard = true,
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
    final shimmerChild = Shimmer.fromColors(
      baseColor: _getBaseColor(context),
      highlightColor: _getHighlightColor(context),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ],
        ),
      ),
    );

    if (useGlassCard) {
      return GlassCard(child: shimmerChild);
    }

    return Card(child: shimmerChild);
  }
}

/// Shimmer loading untuk chart
class ShimmerChartLoading extends StatelessWidget {
  const ShimmerChartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ...List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Container(
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading untuk profile
class ShimmerProfileLoading extends StatelessWidget {
  const ShimmerProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Avatar
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Name
          Container(
            width: 200,
            height: 24,
            color: Colors.white,
          ),
          const SizedBox(height: AppSpacing.sm),
          
          // Email
          Container(
            width: 150,
            height: 16,
            color: Colors.white,
          ),
          const SizedBox(height: AppSpacing.xl),
          
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Container(
                width: 100,
                height: 80,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

