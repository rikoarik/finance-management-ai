import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

/// A modern glass morphism card with frosted glass effect and backdrop blur
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? color;
  final double? blur;
  final double? opacity;
  final List<BoxShadow>? shadows;
  final Border? border;
  final Gradient? gradient;
  final double? elevation;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.blur,
    this.opacity,
    this.shadows,
    this.border,
    this.gradient,
    this.elevation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBlur = blur ?? AppGlass.blur;
    final effectiveOpacity = opacity ?? AppGlass.opacity;
    final effectiveBorderRadius = borderRadius ?? AppRadius.lg;

    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: effectiveBlur,
          sigmaY: effectiveBlur,
        ),
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: gradient == null
                ? (color ?? (isDark ? const Color(0xFF1F2937) : Colors.white))
                    .withOpacity(effectiveOpacity)
                : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            border: border ??
                Border.all(
                  color: Colors.white.withOpacity(isDark ? 0.1 : 0.2),
                  width: 1.5,
                ),
            boxShadow: shadows ??
                (elevation != null
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                          blurRadius: elevation! * 2,
                          offset: Offset(0, elevation!),
                        ),
                      ]
                    : AppThemeHelpers.softShadow()),
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: content,
      );
    }

    if (margin != null) {
      content = Padding(
        padding: margin!,
        child: content,
      );
    }

    return content;
  }
}

/// A glass card with gradient background
class GradientGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Gradient gradient;
  final double? blur;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;

  const GradientGlassCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur,
    this.shadows,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blur: blur,
      opacity: 0.9,
      gradient: gradient,
      shadows: shadows,
      onTap: onTap,
      child: child,
    );
  }
}

/// A compact glass card for smaller UI elements
class CompactGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;

  const CompactGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding ?? const EdgeInsets.all(AppSpacing.sm),
      margin: margin,
      borderRadius: AppRadius.md,
      blur: AppGlass.blurLight,
      opacity: AppGlass.opacityLight,
      color: color,
      onTap: onTap,
      child: child,
    );
  }
}

/// An interactive glass card with hover/press effects
class InteractiveGlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? color;
  final VoidCallback? onTap;
  final bool enabled;

  const InteractiveGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.onTap,
    this.enabled = true,
  });

  @override
  State<InteractiveGlassCard> createState() => _InteractiveGlassCardState();
}

class _InteractiveGlassCardState extends State<InteractiveGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimation.fast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: AppThemeHelpers.pressScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppThemeHelpers.smoothCurve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onTap != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && widget.onTap != null) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled && widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onTap : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GlassCard(
          padding: widget.padding,
          margin: widget.margin,
          borderRadius: widget.borderRadius,
          color: widget.color,
          opacity: widget.enabled ? null : 0.5,
          child: widget.child,
        ),
      ),
    );
  }
}

