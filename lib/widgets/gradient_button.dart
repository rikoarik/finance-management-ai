import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

/// Modern gradient button with smooth animations and effects
class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? elevation;
  final TextStyle? textStyle;
  final Widget? child;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.gradient,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.textStyle,
    this.child,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
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
    if (widget.enabled && !widget.isLoading && widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && !widget.isLoading && widget.onPressed != null) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled && !widget.isLoading && widget.onPressed != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = widget.gradient ?? AppGradients.primary;
    final effectiveEnabled = widget.enabled && !widget.isLoading;
    
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: effectiveEnabled ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: widget.padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
          decoration: BoxDecoration(
            gradient: effectiveEnabled
                ? effectiveGradient
                : LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade400],
                  ),
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? AppRadius.md,
            ),
            boxShadow: effectiveEnabled
                ? AppThemeHelpers.elevatedShadow()
                : null,
          ),
          child: widget.child ?? _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (widget.isLoading) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          widget.text,
          style: widget.textStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

/// Outlined gradient button variant
class OutlineGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final IconData? icon;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const OutlineGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.gradient,
    this.icon,
    this.enabled = true,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ?? AppGradients.primary;

    return Container(
      decoration: BoxDecoration(
        gradient: enabled ? effectiveGradient : null,
        color: enabled ? null : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.md),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular((borderRadius ?? AppRadius.md) - 2),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular((borderRadius ?? AppRadius.md) - 2),
            child: Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    ShaderMask(
                      shaderCallback: (bounds) => effectiveGradient.createShader(bounds),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  ShaderMask(
                    shaderCallback: (bounds) => enabled
                        ? effectiveGradient.createShader(bounds)
                        : const LinearGradient(colors: [Colors.grey, Colors.grey])
                            .createShader(bounds),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact gradient button for smaller spaces
class CompactGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final IconData? icon;
  final bool enabled;

  const CompactGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.gradient,
    this.icon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      gradient: gradient,
      icon: icon,
      enabled: enabled,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      borderRadius: AppRadius.sm,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// Icon-only gradient button
class IconGradientButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final bool enabled;
  final double? size;

  const IconGradientButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.gradient,
    this.enabled = true,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 48.0;

    return GradientButton(
      text: '',
      onPressed: onPressed,
      gradient: gradient,
      enabled: enabled,
      padding: EdgeInsets.all(effectiveSize / 4),
      borderRadius: effectiveSize / 2,
      child: Icon(
        icon,
        color: Colors.white,
        size: effectiveSize / 2,
      ),
    );
  }
}

