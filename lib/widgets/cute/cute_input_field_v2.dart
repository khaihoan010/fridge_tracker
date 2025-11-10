import 'package:flutter/material.dart';
import '../../utils/app_colors_v2.dart';
import '../../utils/app_typography_v2.dart';
import '../../utils/app_spacing_v2.dart';
import '../../utils/app_shadows_v2.dart';

/// 🌸 Cute Input Field V2 - Feminine & Elegant
class CuteInputFieldV2 extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? emoji;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final bool readOnly;
  final VoidCallback? onTap;

  const CuteInputFieldV2({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.emoji,
    this.icon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.suffix,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CuteInputFieldV2> createState() => _CuteInputFieldV2State();
}

class _CuteInputFieldV2State extends State<CuteInputFieldV2> {
  bool _isFocused = false;
  bool _hasError = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.labelText != null) ...[
          Row(
            children: [
              if (widget.emoji != null) ...[
                Text(
                  widget.emoji!,
                  style: const TextStyle(fontSize: 16),
                ),
                AppSpacingV2.hGapXs,
              ],
              Text(
                widget.labelText!,
                style: AppTypographyV2.labelMedium(
                  color: AppColorsV2.charcoalSoft,
                ),
              ),
            ],
          ),
          AppSpacingV2.gapS,
        ],

        // Input field
        AnimatedContainer(
          duration: AppSpacingV2.durationNormal,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColorsV2.snowWhite,
                AppColorsV2.pearlGray.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppSpacingV2.borderM,
            boxShadow: _isFocused
                ? [
                    ...AppShadowsV2.glowPrimary,
                    ...AppShadowsV2.soft,
                  ]
                : (_hasError ? [] : AppShadowsV2.subtle),
            border: Border.all(
              color: _hasError
                  ? AppColorsV2.statusExpiredBorder
                  : (_isFocused
                      ? AppColorsV2.roseQuartz
                      : AppColorsV2.doveGray.withOpacity(0.3)),
              width: _hasError || _isFocused ? 2 : 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            validator: (value) {
              final error = widget.validator?.call(value);
              setState(() {
                _hasError = error != null;
                _errorText = error;
              });
              return error;
            },
            onChanged: widget.onChanged,
            onTap: () {
              widget.onTap?.call();
              setState(() => _isFocused = true);
            },
            onTapOutside: (_) {
              setState(() => _isFocused = false);
              FocusScope.of(context).unfocus();
            },
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            style: AppTypographyV2.bodyMedium(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTypographyV2.bodyMedium(
                color: AppColorsV2.slateMuted,
              ),
              prefixIcon: widget.icon != null
                  ? Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Container(
                        padding: AppSpacingV2.paddingS,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColorsV2.gradientPrimary,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: AppShadowsV2.subtle,
                        ),
                        child: Icon(
                          widget.icon,
                          size: AppSpacingV2.iconS,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
              suffixIcon: widget.suffix,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacingV2.l,
                vertical: AppSpacingV2.m,
              ),
              counterText: '',
            ),
          ),
        ),

        // Error text
        if (_hasError && _errorText != null) ...[
          AppSpacingV2.gapS,
          Row(
            children: [
              Icon(
                Icons.error_rounded,
                size: AppSpacingV2.iconS,
                color: AppColorsV2.statusExpiredText,
              ),
              AppSpacingV2.hGapXs,
              Expanded(
                child: Text(
                  _errorText!,
                  style: AppTypographyV2.bodySmall(
                    color: AppColorsV2.statusExpiredText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
