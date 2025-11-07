import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_shadows.dart';

/// Gradient button with cute styling
class CuteButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final List<Color>? gradientColors;
  final bool isOutlined;
  final bool isDisabled;
  final bool isSmall;

  const CuteButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradientColors,
    this.isOutlined = false,
    this.isDisabled = false,
    this.isSmall = false,
  });

  @override
  State<CuteButton> createState() => _CuteButtonState();
}

class _CuteButtonState extends State<CuteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled) {
      _controller.reverse();
      widget.onPressed();
    }
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = widget.gradientColors ?? AppColors.gradientUnicorn;
    final padding = widget.isSmall
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
        : const EdgeInsets.symmetric(horizontal: 24, vertical: 14);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Opacity(
          opacity: widget.isDisabled ? 0.5 : 1.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.isOutlined
                  ? null
                  : LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: widget.isOutlined ? AppColors.backgroundNeu : null,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: widget.isOutlined
                  ? Border.all(color: gradientColors.first, width: 2)
                  : null,
              boxShadow: widget.isOutlined ? AppShadows.neuEmbossed : AppShadows.neuStrong,
            ),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: widget.isOutlined ? gradientColors.first : AppColors.textWhite,
                      size: widget.isSmall ? AppSpacing.iconS : AppSpacing.iconM,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: (widget.isSmall ? AppTypography.labelMedium : AppTypography.labelLarge)
                        .copyWith(
                      color: widget.isOutlined ? gradientColors.first : AppColors.textWhite,
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
