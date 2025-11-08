import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Draggable handle for bottom sheets
class BottomSheetHandle extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const BottomSheetHandle({
    super.key,
    this.color,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      width: width ?? 40,
      height: height ?? 4,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).dividerColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Bottom sheet wrapper with handle and modern styling
class ModernBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showHandle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;

  const ModernBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showHandle = true,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppRadius.xl;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(effectiveBorderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            if (showHandle) const BottomSheetHandle(),
            
            // Header with title and actions
            if (title != null || actions != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: Text(
                          title!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    if (actions != null) ...actions!,
                  ],
                ),
              ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows a modern bottom sheet with handle
Future<T?> showModernBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  List<Widget>? actions,
  bool showHandle = true,
  bool isDismissible = true,
  bool enableDrag = true,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? backgroundColor,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ModernBottomSheet(
      title: title,
      actions: actions,
      showHandle: showHandle,
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      child: child,
    ),
  );
}

/// Draggable bottom sheet that can be expanded/collapsed
class DraggableBottomSheet extends StatefulWidget {
  final Widget child;
  final Widget collapsed;
  final double minHeight;
  final double maxHeight;
  final bool showHandle;
  final Color? backgroundColor;

  const DraggableBottomSheet({
    super.key,
    required this.child,
    required this.collapsed,
    this.minHeight = 120,
    this.maxHeight = 600,
    this.showHandle = true,
    this.backgroundColor,
  });

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppAnimation.medium,
      curve: Curves.easeInOut,
      height: _isExpanded ? widget.maxHeight : widget.minHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle
          if (widget.showHandle)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: const BottomSheetHandle(),
            ),
          
          // Content
          Expanded(
            child: _isExpanded ? widget.child : widget.collapsed,
          ),
        ],
      ),
    );
  }
}

