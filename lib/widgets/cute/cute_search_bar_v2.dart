import 'package:flutter/material.dart';
import '../../utils/app_colors_v2.dart';
import '../../utils/app_typography_v2.dart';
import '../../utils/app_spacing_v2.dart';
import '../../utils/app_shadows_v2.dart';

/// 🌸 Cute Search Bar V2 - Feminine & Modern
class CuteSearchBarV2 extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final String? emoji;

  const CuteSearchBarV2({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = 'Tìm kiếm...',
    this.emoji = '🔍',
  });

  @override
  State<CuteSearchBarV2> createState() => _CuteSearchBarV2State();
}

class _CuteSearchBarV2State extends State<CuteSearchBarV2>
    with SingleTickerProviderStateMixin {
  late AnimationController _focusController;
  late Animation<double> _glowAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusController = AnimationController(
      duration: AppSpacingV2.durationNormal,
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _focusController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _focusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColorsV2.snowWhite,
                AppColorsV2.pearlGray.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppSpacingV2.borderFull,
            boxShadow: _isFocused
                ? [
                    ...AppShadowsV2.glowPrimary,
                    ...AppShadowsV2.soft,
                  ]
                : AppShadowsV2.soft,
            border: Border.all(
              color: _isFocused
                  ? AppColorsV2.roseQuartz.withOpacity(0.5)
                  : AppColorsV2.doveGray.withOpacity(0.3),
              width: _isFocused ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onTap: () {
              setState(() => _isFocused = true);
              _focusController.forward();
            },
            onTapOutside: (_) {
              setState(() => _isFocused = false);
              _focusController.reverse();
              FocusScope.of(context).unfocus();
            },
            style: AppTypographyV2.bodyMedium(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTypographyV2.bodyMedium(
                color: AppColorsV2.slateMuted,
              ),
              // Prefix icon with emoji
              prefixIcon: Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  widget.emoji ?? '🔍',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              // Suffix clear button
              suffixIcon: widget.controller != null &&
                      widget.controller!.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        widget.controller?.clear();
                        widget.onClear?.call();
                        widget.onChanged?.call('');
                      },
                      icon: Container(
                        padding: AppSpacingV2.paddingXs,
                        decoration: BoxDecoration(
                          color: AppColorsV2.roseQuartz.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: AppSpacingV2.iconS,
                          color: AppColorsV2.charcoalSoft,
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacingV2.l,
                vertical: AppSpacingV2.m,
              ),
            ),
          ),
        );
      },
    );
  }
}
