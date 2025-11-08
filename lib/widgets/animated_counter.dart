import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

/// Animated counter that smoothly transitions between numbers
class AnimatedCounter extends StatefulWidget {
  final double value;
  final TextStyle? textStyle;
  final Duration duration;
  final Curve curve;
  final bool isCurrency;
  final int decimalPlaces;
  final String? prefix;
  final String? suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.textStyle,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.isCurrency = false,
    this.decimalPlaces = 0,
    this.prefix,
    this.suffix,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: _previousValue,
      end: widget.value,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _controller.reset();
      _animation = Tween<double>(
        begin: _previousValue,
        end: widget.value,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(double value) {
    if (widget.isCurrency) {
      return formatCurrency(value);
    }
    return value.toStringAsFixed(widget.decimalPlaces);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final formattedValue = _formatValue(_animation.value);
        return Text(
          '${widget.prefix ?? ''}$formattedValue${widget.suffix ?? ''}',
          style: widget.textStyle,
        );
      },
    );
  }
}

/// Compact animated counter for inline use
class CompactAnimatedCounter extends StatelessWidget {
  final double value;
  final bool isCurrency;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CompactAnimatedCounter({
    super.key,
    required this.value,
    this.isCurrency = true,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCounter(
      value: value,
      isCurrency: isCurrency,
      textStyle: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}

/// Large animated counter for hero displays
class HeroAnimatedCounter extends StatelessWidget {
  final double value;
  final bool isCurrency;
  final Color? color;
  final Gradient? gradient;

  const HeroAnimatedCounter({
    super.key,
    required this.value,
    this.isCurrency = true,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final counter = AnimatedCounter(
      value: value,
      isCurrency: isCurrency,
      duration: AppAnimation.slow,
      textStyle: TextStyle(
        color: color ?? Theme.of(context).textTheme.headlineLarge?.color,
        fontSize: 42,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    );

    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(bounds),
        child: counter,
      );
    }

    return counter;
  }
}

/// Animated percentage display
class AnimatedPercentage extends StatelessWidget {
  final double value;
  final Color? color;
  final TextStyle? textStyle;
  final bool showSign;

  const AnimatedPercentage({
    super.key,
    required this.value,
    this.color,
    this.textStyle,
    this.showSign = true,
  });

  @override
  Widget build(BuildContext context) {
    final sign = showSign && value > 0 ? '+' : '';
    return AnimatedCounter(
      value: value,
      isCurrency: false,
      decimalPlaces: 1,
      prefix: sign,
      suffix: '%',
      textStyle: textStyle ??
          TextStyle(
            color: color ??
                (value >= 0
                    ? AppColors.success
                    : AppColors.error),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

/// Animated trend indicator with icon
class AnimatedTrendIndicator extends StatelessWidget {
  final double value;
  final double? previousValue;
  final bool isCurrency;
  final TextStyle? textStyle;

  const AnimatedTrendIndicator({
    super.key,
    required this.value,
    this.previousValue,
    this.isCurrency = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (previousValue == null) {
      return AnimatedCounter(
        value: value,
        isCurrency: isCurrency,
        textStyle: textStyle,
      );
    }

    final isIncrease = value > previousValue!;
    final percentChange =
        previousValue! != 0 ? ((value - previousValue!) / previousValue!) * 100 : 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedCounter(
          value: value,
          isCurrency: isCurrency,
          textStyle: textStyle,
        ),
        const SizedBox(width: AppSpacing.xs),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: (isIncrease ? AppColors.success : AppColors.error)
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isIncrease ? Icons.trending_up : Icons.trending_down,
                size: 14,
                color: isIncrease ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 2),
              Text(
                '${percentChange.abs().toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isIncrease ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

