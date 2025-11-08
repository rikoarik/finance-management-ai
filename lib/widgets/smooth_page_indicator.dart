import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Animated smooth page indicator for onboarding and carousels
class SmoothPageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? dotSize;
  final double? spacing;
  final IndicatorEffect effect;

  const SmoothPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.dotSize,
    this.spacing,
    this.effect = IndicatorEffect.worm,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    final effectiveInactiveColor = inactiveColor ?? AppColors.grey;
    final effectiveDotSize = dotSize ?? 8.0;
    final effectiveSpacing = spacing ?? 8.0;

    switch (effect) {
      case IndicatorEffect.worm:
        return _WormIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          dotSize: effectiveDotSize,
          spacing: effectiveSpacing,
        );
      case IndicatorEffect.expanding:
        return _ExpandingIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          dotSize: effectiveDotSize,
          spacing: effectiveSpacing,
        );
      case IndicatorEffect.jumping:
        return _JumpingIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          dotSize: effectiveDotSize,
          spacing: effectiveSpacing,
        );
      case IndicatorEffect.scale:
        return _ScaleIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          dotSize: effectiveDotSize,
          spacing: effectiveSpacing,
        );
    }
  }
}

enum IndicatorEffect {
  worm,
  expanding,
  jumping,
  scale,
}

/// Worm effect - Active dot expands horizontally
class _WormIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;

  const _WormIndicator({
    required this.count,
    required this.currentIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: AppAnimation.medium,
          curve: Curves.easeInOut,
          width: isActive ? dotSize * 3 : dotSize,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}

/// Expanding effect - Active dot scales up
class _ExpandingIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;

  const _ExpandingIndicator({
    required this.count,
    required this.currentIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: AppAnimation.medium,
          curve: Curves.easeInOut,
          width: isActive ? dotSize * 2.5 : dotSize,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}

/// Jumping effect - Active dot jumps up
class _JumpingIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;

  const _JumpingIndicator({
    required this.count,
    required this.currentIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dotSize * 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(count, (index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: AppAnimation.medium,
            curve: Curves.easeInOut,
            width: dotSize,
            height: dotSize,
            margin: EdgeInsets.only(
              left: spacing / 2,
              right: spacing / 2,
              bottom: isActive ? dotSize * 0.5 : 0,
            ),
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}

/// Scale effect - Active dot scales and changes color
class _ScaleIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;

  const _ScaleIndicator({
    required this.count,
    required this.currentIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: AppAnimation.medium,
          curve: Curves.easeInOut,
          width: isActive ? dotSize * 1.5 : dotSize,
          height: isActive ? dotSize * 1.5 : dotSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: activeColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}

/// Gradient page indicator with smooth transitions
class GradientPageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Gradient gradient;
  final Color? inactiveColor;
  final double? dotSize;
  final double? spacing;

  const GradientPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.gradient,
    this.inactiveColor,
    this.dotSize,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveInactiveColor = inactiveColor ?? AppColors.grey;
    final effectiveDotSize = dotSize ?? 8.0;
    final effectiveSpacing = spacing ?? 8.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: AppAnimation.medium,
          curve: Curves.easeInOut,
          width: isActive ? effectiveDotSize * 3 : effectiveDotSize,
          height: effectiveDotSize,
          margin: EdgeInsets.symmetric(horizontal: effectiveSpacing / 2),
          decoration: BoxDecoration(
            gradient: isActive ? gradient : null,
            color: isActive ? null : effectiveInactiveColor,
            borderRadius: BorderRadius.circular(effectiveDotSize / 2),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}

/// Progress bar style indicator
class ProgressBarIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? height;

  const ProgressBarIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    final effectiveInactiveColor = inactiveColor ?? AppColors.grey;
    final effectiveHeight = height ?? 4.0;

    return SizedBox(
      height: effectiveHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveHeight / 2),
        child: LinearProgressIndicator(
          value: (currentIndex + 1) / count,
          backgroundColor: effectiveInactiveColor,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveActiveColor),
          minHeight: effectiveHeight,
        ),
      ),
    );
  }
}

