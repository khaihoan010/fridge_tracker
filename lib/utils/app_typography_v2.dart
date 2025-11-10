import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors_v2.dart';

/// 🌸 Typography System V2 - Rounded & Gentle
class AppTypographyV2 {
  // ========================================
  // 📝 FONT FAMILIES
  // ========================================

  /// Primary font - Quicksand (Rounded, friendly)
  static TextStyle _baseQuicksand(
    double fontSize,
    FontWeight fontWeight,
    Color? color,
  ) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColorsV2.charcoalSoft,
      letterSpacing: 0.3,
    );
  }

  /// Secondary font - Nunito (Soft, readable)
  static TextStyle _baseNunito(
    double fontSize,
    FontWeight fontWeight,
    Color? color,
  ) {
    return GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColorsV2.charcoalSoft,
      letterSpacing: 0.2,
    );
  }

  // ========================================
  // 🎯 DISPLAY STYLES - Hero Text
  // ========================================

  /// Hero Large - 32px / Bold
  static TextStyle heroLarge({Color? color}) {
    return _baseQuicksand(32, FontWeight.w700, color).copyWith(
      height: 1.2,
      letterSpacing: -0.5,
    );
  }

  /// Hero Medium - 28px / Bold
  static TextStyle heroMedium({Color? color}) {
    return _baseQuicksand(28, FontWeight.w700, color).copyWith(
      height: 1.25,
      letterSpacing: -0.3,
    );
  }

  // ========================================
  // 📰 TITLE STYLES - Section Headers
  // ========================================

  /// Title Large - 24px / SemiBold
  static TextStyle titleLarge({Color? color}) {
    return _baseQuicksand(24, FontWeight.w600, color).copyWith(
      height: 1.3,
    );
  }

  /// Title Medium - 20px / SemiBold
  static TextStyle titleMedium({Color? color}) {
    return _baseQuicksand(20, FontWeight.w600, color).copyWith(
      height: 1.4,
    );
  }

  /// Title Small - 18px / SemiBold
  static TextStyle titleSmall({Color? color}) {
    return _baseQuicksand(18, FontWeight.w600, color).copyWith(
      height: 1.4,
    );
  }

  // ========================================
  // 📄 BODY STYLES - Content Text
  // ========================================

  /// Body Large - 16px / Regular
  static TextStyle bodyLarge({Color? color}) {
    return _baseNunito(16, FontWeight.w400, color).copyWith(
      height: 1.5,
    );
  }

  /// Body Medium - 14px / Regular
  static TextStyle bodyMedium({Color? color}) {
    return _baseNunito(14, FontWeight.w400, color).copyWith(
      height: 1.5,
    );
  }

  /// Body Small - 12px / Regular
  static TextStyle bodySmall({Color? color}) {
    return _baseNunito(12, FontWeight.w400, color).copyWith(
      height: 1.4,
    );
  }

  // ========================================
  // 🏷️ LABEL STYLES - Tags & Badges
  // ========================================

  /// Label Large - 14px / SemiBold
  static TextStyle labelLarge({Color? color}) {
    return _baseQuicksand(14, FontWeight.w600, color).copyWith(
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  /// Label Medium - 12px / SemiBold
  static TextStyle labelMedium({Color? color}) {
    return _baseQuicksand(12, FontWeight.w600, color).copyWith(
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  /// Label Small - 11px / SemiBold
  static TextStyle labelSmall({Color? color}) {
    return _baseQuicksand(11, FontWeight.w600, color).copyWith(
      height: 1.2,
      letterSpacing: 0.4,
    );
  }

  // ========================================
  // 🔢 NUMBER STYLES - Monospace
  // ========================================

  /// Number Large - For prominent numbers
  static TextStyle numberLarge({Color? color}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color ?? AppColorsV2.charcoalSoft,
      height: 1.2,
    );
  }

  /// Number Medium - For regular numbers
  static TextStyle numberMedium({Color? color}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? AppColorsV2.charcoalSoft,
      height: 1.3,
    );
  }

  // ========================================
  // 🎨 COLORED TEXT VARIANTS
  // ========================================

  /// Primary colored text
  static TextStyle withPrimaryColor(TextStyle base) {
    return base.copyWith(
      color: AppColorsV2.roseQuartz,
      shadows: [
        Shadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.3),
          blurRadius: 8,
        ),
      ],
    );
  }

  /// Secondary colored text
  static TextStyle withSecondaryColor(TextStyle base) {
    return base.copyWith(color: AppColorsV2.slateMuted);
  }

  /// Gradient text effect (requires additional widget)
  static TextStyle gradientText(TextStyle base) {
    return base.copyWith(
      foreground: Paint()
        ..shader = const LinearGradient(
          colors: AppColorsV2.gradientPrimary,
        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
    );
  }

  // ========================================
  // 💫 TEXT DECORATIONS
  // ========================================

  /// Add soft shadow to text
  static TextStyle withSoftShadow(TextStyle base) {
    return base.copyWith(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    );
  }

  /// Add glow effect to text
  static TextStyle withGlow(TextStyle base, Color glowColor) {
    return base.copyWith(
      shadows: [
        Shadow(
          color: glowColor.withOpacity(0.5),
          blurRadius: 12,
        ),
        Shadow(
          color: glowColor.withOpacity(0.3),
          blurRadius: 24,
        ),
      ],
    );
  }

  // ========================================
  // 📐 TEXT ALIGNMENT HELPERS
  // ========================================

  static const TextAlign left = TextAlign.left;
  static const TextAlign center = TextAlign.center;
  static const TextAlign right = TextAlign.right;
}
