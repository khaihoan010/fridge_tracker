import 'package:flutter/material.dart';
import '../../utils/app_colors_v2.dart';
import '../../utils/app_typography_v2.dart';
import '../../utils/app_spacing_v2.dart';
import '../../utils/app_shadows_v2.dart';

/// 🌸 Cute Button V2 - Feminine & Delightful
enum CuteButtonType {
  primary, // Gradient button
  secondary, // Outlined button
  ghost, // Text only
  soft, // Soft colored background
}

enum CuteButtonSize {
  small,
  medium,
  large,
}

class CuteButtonV2 extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final CuteButtonType type;
  final CuteButtonSize size;
  final IconData? icon;
  final String? emoji;
  final bool isLoading;
  final bool fullWidth;
  final List<Color>? customGradient;

  const CuteButtonV2({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CuteButtonType.primary,
    this.size = CuteButtonSize.medium,
    this.icon,
    this.emoji,
    this.isLoading = false,
    this.fullWidth = false,
    this.customGradient,
  });

  @override
  State<CuteButtonV2> createState() => _CuteButtonV2State();
}

class _CuteButtonV2State extends State<CuteButtonV2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppSpacingV2.durationFast,
      vsync: this,
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
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: isEnabled ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: AppSpacingV2.durationNormal,
          width: widget.fullWidth ? double.infinity : null,
          height: _getButtonHeight(),
          decoration: _getDecoration(isEnabled),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isEnabled ? widget.onPressed : null,
              borderRadius: AppSpacingV2.borderFull,
              child: Center(
                child: widget.isLoading
                    ? _buildLoadingIndicator()
                    : _buildContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case CuteButtonSize.small:
        return AppSpacingV2.buttonHeightSmall;
      case CuteButtonSize.large:
        return AppSpacingV2.buttonHeightLarge;
      case CuteButtonSize.medium:
      default:
        return AppSpacingV2.buttonHeight;
    }
  }

  BoxDecoration _getDecoration(bool isEnabled) {
    final opacity = isEnabled ? 1.0 : 0.5;

    switch (widget.type) {
      case CuteButtonType.primary:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: (widget.customGradient ?? AppColorsV2.gradientPrimary)
                .map((c) => c.withOpacity(opacity))
                .toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppSpacingV2.borderFull,
          boxShadow: isEnabled
              ? (_isPressed ? AppShadowsV2.subtle : AppShadowsV2.medium)
              : [],
        );

      case CuteButtonType.secondary:
        return BoxDecoration(
          color: AppColorsV2.snowWhite.withOpacity(opacity),
          border: Border.all(
            color: AppColorsV2.roseQuartz.withOpacity(opacity),
            width: 2,
          ),
          borderRadius: AppSpacingV2.borderFull,
          boxShadow: isEnabled
              ? (_isPressed ? [] : AppShadowsV2.subtle)
              : [],
        );

      case CuteButtonType.ghost:
        return BoxDecoration(
          color: _isPressed
              ? AppColorsV2.roseQuartz.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: AppSpacingV2.borderFull,
        );

      case CuteButtonType.soft:
        return BoxDecoration(
          color: AppColorsV2.roseQuartz.withOpacity(opacity * 0.2),
          borderRadius: AppSpacingV2.borderFull,
          boxShadow: isEnabled
              ? (_isPressed ? [] : AppShadowsV2.subtle)
              : [],
        );
    }
  }

  Widget _buildContent() {
    final textStyle = _getTextStyle();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacingV2.l),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              size: _getIconSize(),
              color: textStyle.color,
            ),
            AppSpacingV2.hGapS,
          ],
          if (widget.emoji != null) ...[
            Text(
              widget.emoji!,
              style: TextStyle(fontSize: _getEmojiSize()),
            ),
            AppSpacingV2.hGapS,
          ],
          Text(widget.text, style: textStyle),
        ],
      ),
    );
  }

  TextStyle _getTextStyle() {
    final baseStyle = widget.size == CuteButtonSize.large
        ? AppTypographyV2.labelLarge()
        : AppTypographyV2.labelMedium();

    switch (widget.type) {
      case CuteButtonType.primary:
        return baseStyle.copyWith(color: Colors.white);
      case CuteButtonType.secondary:
      case CuteButtonType.soft:
        return baseStyle.copyWith(color: AppColorsV2.charcoalSoft);
      case CuteButtonType.ghost:
        return baseStyle.copyWith(color: AppColorsV2.roseQuartz);
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case CuteButtonSize.small:
        return AppSpacingV2.iconS;
      case CuteButtonSize.large:
        return AppSpacingV2.iconL;
      case CuteButtonSize.medium:
      default:
        return AppSpacingV2.iconM;
    }
  }

  double _getEmojiSize() {
    switch (widget.size) {
      case CuteButtonSize.small:
        return 16;
      case CuteButtonSize.large:
        return 24;
      case CuteButtonSize.medium:
      default:
        return 20;
    }
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.type == CuteButtonType.primary
              ? Colors.white
              : AppColorsV2.roseQuartz,
        ),
      ),
    );
  }
}
