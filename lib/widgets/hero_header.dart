import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'animated_counter.dart';

/// Large hero section for screen headers with gradient background
class HeroHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final Gradient? gradient;
  final double? height;
  final Widget? bottom;

  const HeroHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.gradient,
    this.height,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ?? AppGradients.primary;
    final effectiveHeight = height ?? 120.0;

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        gradient: effectiveGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar with actions
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: AppSpacing.md),
                  ],
                  const Spacer(),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            
            // Title and subtitle
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Bottom widget (if provided)
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}

/// Hero header specifically for displaying balance/financial data
class BalanceHeroHeader extends StatelessWidget {
  final String title;
  final double balance;
  final String? period;
  final List<Widget>? actions;
  final Gradient? gradient;
  final Widget? additionalInfo;

  const BalanceHeroHeader({
    super.key,
    required this.title,
    required this.balance,
    this.period,
    this.actions,
    this.gradient,
    this.additionalInfo,
  });

  @override
  Widget build(BuildContext context) {
    return HeroHeader(
      title: title,
      subtitle: period,
      actions: actions,
      gradient: gradient,
      height: additionalInfo != null ? 160 : 140,
      bottom: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: HeroAnimatedCounter(
              value: balance,
              isCurrency: true,
              color: Colors.white,
            ),
          ),
          if (additionalInfo != null) ...[
            const SizedBox(height: AppSpacing.md),
            additionalInfo!,
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

/// Compact hero header for secondary screens
class CompactHeroHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Gradient? gradient;

  const CompactHeroHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.actions,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return HeroHeader(
      title: title,
      subtitle: subtitle,
      leading: onBackPressed != null
          ? IconButton(
              onPressed: onBackPressed,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            )
          : null,
      actions: actions,
      gradient: gradient,
      height: 100,
    );
  }
}

/// Hero header with search functionality
class SearchableHeroHeader extends StatelessWidget {
  final String title;
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<Widget>? actions;
  final Gradient? gradient;

  const SearchableHeroHeader({
    super.key,
    required this.title,
    this.searchHint,
    this.onSearchChanged,
    this.actions,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return HeroHeader(
      title: title,
      actions: actions,
      gradient: gradient,
      height: 160,
      bottom: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: onSearchChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: searchHint ?? 'Search...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.white.withOpacity(0.9),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Hero header with tab bar
class TabbedHeroHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final TabBar tabBar;
  final Gradient? gradient;

  const TabbedHeroHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    required this.tabBar,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return HeroHeader(
      title: title,
      subtitle: subtitle,
      actions: actions,
      gradient: gradient,
      height: 140,
      bottom: Theme(
        data: ThemeData(
          tabBarTheme: TabBarThemeData(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: tabBar,
      ),
    );
  }
}
