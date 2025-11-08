import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Speed dial floating action menu for quick actions
class FloatingActionMenu extends StatefulWidget {
  final List<FloatingActionMenuItem> items;
  final IconData icon;
  final IconData? activeIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Gradient? gradient;
  final String? tooltip;

  const FloatingActionMenu({
    super.key,
    required this.items,
    this.icon = Icons.add,
    this.activeIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.tooltip,
  });

  @override
  State<FloatingActionMenu> createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimation.medium,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: math.pi / 4, // 45 degrees
    ).animate(_expandAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleItemTap(FloatingActionMenuItem item) {
    _toggle();
    item.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Overlay to detect taps outside
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        
        // Menu items
        ..._buildMenuItems(),
        
        // Main FAB
        const SizedBox(height: AppSpacing.sm),
        _buildMainButton(),
      ],
    );
  }

  List<Widget> _buildMenuItems() {
    return List.generate(widget.items.length, (index) {
      final item = widget.items[widget.items.length - 1 - index];
      return AnimatedBuilder(
        animation: _expandAnimation,
        builder: (context, child) {
          final offset = _expandAnimation.value * (index + 1) * 70.0;
          return Transform.translate(
            offset: Offset(0, -offset),
            child: Opacity(
              opacity: _expandAnimation.value,
              child: ScaleTransition(
                scale: _expandAnimation,
                child: child,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Label
              if (item.label != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    item.label!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              
              const SizedBox(width: AppSpacing.sm),
              
              // Button
              FloatingActionButton(
                heroTag: 'fab_item_${item.label}',
                mini: true,
                onPressed: () => _handleItemTap(item),
                backgroundColor: item.backgroundColor ?? Theme.of(context).colorScheme.secondary,
                foregroundColor: item.foregroundColor ?? Colors.white,
                child: Icon(item.icon),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMainButton() {
    final effectiveBackgroundColor = widget.backgroundColor ?? Theme.of(context).colorScheme.primary;
    final effectiveForegroundColor = widget.foregroundColor ?? Colors.white;

    return FloatingActionButton(
      heroTag: 'fab_main',
      onPressed: _toggle,
      tooltip: widget.tooltip,
      child: AnimatedBuilder(
        animation: _rotateAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotateAnimation.value,
            child: Icon(
              _isExpanded ? (widget.activeIcon ?? Icons.close) : widget.icon,
              color: effectiveForegroundColor,
            ),
          );
        },
      ),
      backgroundColor: effectiveBackgroundColor,
    );
  }
}

/// Menu item for FloatingActionMenu
class FloatingActionMenuItem {
  final String? label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const FloatingActionMenuItem({
    this.label,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });
}

/// Compact speed dial menu (no labels, just icons)
class CompactFloatingActionMenu extends StatefulWidget {
  final List<FloatingActionMenuItem> items;
  final IconData icon;
  final IconData? activeIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CompactFloatingActionMenu({
    super.key,
    required this.items,
    this.icon = Icons.add,
    this.activeIcon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<CompactFloatingActionMenu> createState() => _CompactFloatingActionMenuState();
}

class _CompactFloatingActionMenuState extends State<CompactFloatingActionMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimation.fast,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleItemTap(FloatingActionMenuItem item) {
    _toggle();
    item.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(widget.items.length, (index) {
          final item = widget.items[widget.items.length - 1 - index];
          return AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              final offset = _expandAnimation.value * (index + 1) * 60.0;
              return Transform.translate(
                offset: Offset(0, -offset),
                child: Opacity(
                  opacity: _expandAnimation.value,
                  child: ScaleTransition(
                    scale: _expandAnimation,
                    child: child,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: FloatingActionButton(
                heroTag: 'compact_fab_${item.icon}',
                mini: true,
                onPressed: () => _handleItemTap(item),
                backgroundColor: item.backgroundColor ?? Theme.of(context).colorScheme.secondary,
                child: Icon(
                  item.icon,
                  color: item.foregroundColor ?? Colors.white,
                ),
              ),
            ),
          );
        }),
        
        FloatingActionButton(
          heroTag: 'compact_fab_main',
          onPressed: _toggle,
          backgroundColor: widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
          child: AnimatedSwitcher(
            duration: AppAnimation.fast,
            child: Icon(
              _isExpanded ? (widget.activeIcon ?? Icons.close) : widget.icon,
              key: ValueKey(_isExpanded),
              color: widget.foregroundColor ?? Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

