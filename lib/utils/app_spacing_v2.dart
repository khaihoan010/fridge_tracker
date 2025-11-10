import 'package:flutter/material.dart';

/// 🌸 Spacing & Layout System V2 - Breathing Room
class AppSpacingV2 {
  // ========================================
  // 📏 SPACING SCALE
  // ========================================

  static const double xs = 4.0; // Extra small
  static const double s = 8.0; // Small
  static const double m = 12.0; // Medium
  static const double l = 16.0; // Large
  static const double xl = 20.0; // Extra large
  static const double xxl = 24.0; // 2X large
  static const double xxxl = 32.0; // 3X large
  static const double huge = 48.0; // Huge

  // ========================================
  // 🎨 BORDER RADIUS - Extra Rounded
  // ========================================

  static const double radiusXs = 4.0; // Badges
  static const double radiusS = 8.0; // Small buttons
  static const double radiusM = 12.0; // Input fields
  static const double radiusL = 16.0; // Cards
  static const double radiusXl = 20.0; // Large cards
  static const double radiusXxl = 24.0; // Hero cards
  static const double radiusFull = 999.0; // Pills, circular

  // Convenience BorderRadius objects
  static BorderRadius get borderXs => BorderRadius.circular(radiusXs);
  static BorderRadius get borderS => BorderRadius.circular(radiusS);
  static BorderRadius get borderM => BorderRadius.circular(radiusM);
  static BorderRadius get borderL => BorderRadius.circular(radiusL);
  static BorderRadius get borderXl => BorderRadius.circular(radiusXl);
  static BorderRadius get borderXxl => BorderRadius.circular(radiusXxl);
  static BorderRadius get borderFull => BorderRadius.circular(radiusFull);

  // ========================================
  // 💫 COMMON EDGE INSETS
  // ========================================

  /// All sides padding
  static EdgeInsets all(double value) => EdgeInsets.all(value);

  /// Symmetric padding
  static EdgeInsets symmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }

  /// Custom padding
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  // Preset paddings
  static EdgeInsets get paddingXs => all(xs);
  static EdgeInsets get paddingS => all(s);
  static EdgeInsets get paddingM => all(m);
  static EdgeInsets get paddingL => all(l);
  static EdgeInsets get paddingXl => all(xl);
  static EdgeInsets get paddingXxl => all(xxl);
  static EdgeInsets get paddingXxxl => all(xxxl);

  /// Screen horizontal padding
  static EdgeInsets get screenPadding => symmetric(horizontal: l);

  /// Card padding
  static EdgeInsets get cardPadding => all(l);

  /// Section padding
  static EdgeInsets get sectionPadding => symmetric(vertical: xxl, horizontal: l);

  // ========================================
  // 📐 COMMON SIZED BOXES
  // ========================================

  /// Vertical spacing
  static SizedBox get gapXs => const SizedBox(height: xs);
  static SizedBox get gapS => const SizedBox(height: s);
  static SizedBox get gapM => const SizedBox(height: m);
  static SizedBox get gapL => const SizedBox(height: l);
  static SizedBox get gapXl => const SizedBox(height: xl);
  static SizedBox get gapXxl => const SizedBox(height: xxl);
  static SizedBox get gapXxxl => const SizedBox(height: xxxl);
  static SizedBox get gapHuge => const SizedBox(height: huge);

  /// Horizontal spacing
  static SizedBox get hGapXs => const SizedBox(width: xs);
  static SizedBox get hGapS => const SizedBox(width: s);
  static SizedBox get hGapM => const SizedBox(width: m);
  static SizedBox get hGapL => const SizedBox(width: l);
  static SizedBox get hGapXl => const SizedBox(width: xl);
  static SizedBox get hGapXxl => const SizedBox(width: xxl);

  // ========================================
  // 🎯 ICON SIZES
  // ========================================

  static const double iconXs = 12.0;
  static const double iconS = 16.0;
  static const double iconM = 20.0;
  static const double iconL = 24.0;
  static const double iconXl = 32.0;
  static const double iconXxl = 48.0;
  static const double iconHuge = 64.0;

  // ========================================
  // 📱 TOUCH TARGETS
  // ========================================

  /// Minimum touch target size (accessibility)
  static const double minTouchTarget = 44.0;

  /// Button height
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;

  // ========================================
  // 🖼️ IMAGE & THUMBNAIL SIZES
  // ========================================

  static const double thumbnailSmall = 40.0;
  static const double thumbnailMedium = 60.0;
  static const double thumbnailLarge = 80.0;
  static const double thumbnailHero = 120.0;

  // ========================================
  // 📊 ELEVATION (for Material)
  // ========================================

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationFloat = 12.0;

  // ========================================
  // 🎨 DIVIDER & BORDER WIDTHS
  // ========================================

  static const double borderThin = 1.0;
  static const double borderMedium = 2.0;
  static const double borderThick = 3.0;

  // ========================================
  // 💫 ANIMATION DURATIONS (milliseconds)
  // ========================================

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);
}
