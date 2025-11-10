import 'package:flutter/material.dart';
import 'app_colors_v2.dart';

/// 🌸 Shadow System V2 - Soft & Subtle
class AppShadowsV2 {
  // ========================================
  // 💫 SOFT SHADOWS - Cards & Elements
  // ========================================

  /// Soft shadow - For cards
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ];

  /// Medium shadow - Floating elements
  static List<BoxShadow> get medium => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.20),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  /// Strong shadow - Modals & dialogs
  static List<BoxShadow> get strong => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.25),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Subtle shadow - Minimal depth
  static List<BoxShadow> get subtle => [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  // ========================================
  // ✨ GLOW EFFECTS - Active States
  // ========================================

  /// Primary glow - Rose
  static List<BoxShadow> get glowPrimary => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.4),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];

  /// Secondary glow - Lavender
  static List<BoxShadow> get glowSecondary => [
        BoxShadow(
          color: AppColorsV2.lavenderMist.withOpacity(0.4),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];

  /// Success glow - Mint
  static List<BoxShadow> get glowSuccess => [
        BoxShadow(
          color: AppColorsV2.mintCream.withOpacity(0.5),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];

  /// Warning glow - Peach
  static List<BoxShadow> get glowWarning => [
        BoxShadow(
          color: AppColorsV2.peachBlossom.withOpacity(0.5),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];

  // ========================================
  // 🎨 COLORED SHADOWS - Category Specific
  // ========================================

  /// Get colored shadow for categories
  static List<BoxShadow> getCategoryShadow(String categoryId) {
    final color = AppColorsV2.getCategoryColor(categoryId);
    return [
      BoxShadow(
        color: color.withOpacity(0.25),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ];
  }

  // ========================================
  // 🔲 INNER SHADOWS (Inset Effect)
  // ========================================

  /// Inner shadow - For pressed states
  /// Note: BoxShadow doesn't support inset in Flutter
  /// Use CustomPaint or Stack for true inset shadows
  static BoxDecoration get innerShadow => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      );

  // ========================================
  // 🎯 ELEVATION HELPERS
  // ========================================

  /// Get shadow based on elevation level
  static List<BoxShadow> elevation(int level) {
    switch (level) {
      case 0:
        return [];
      case 1:
        return subtle;
      case 2:
        return soft;
      case 3:
        return medium;
      case 4:
      case 5:
        return strong;
      default:
        return strong;
    }
  }

  // ========================================
  // 💫 CUSTOM SHADOW BUILDER
  // ========================================

  /// Build custom shadow with specific parameters
  static List<BoxShadow> custom({
    required Color color,
    double opacity = 0.2,
    double blurRadius = 8,
    Offset offset = const Offset(0, 2),
    double spreadRadius = 0,
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        blurRadius: blurRadius,
        offset: offset,
        spreadRadius: spreadRadius,
      ),
    ];
  }

  // ========================================
  // 🌈 MULTI-COLOR SHADOWS (for gradients)
  // ========================================

  /// Rainbow shadow effect
  static List<BoxShadow> get rainbow => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(-4, 4),
        ),
        BoxShadow(
          color: AppColorsV2.lavenderMist.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(4, 4),
        ),
      ];

  // ========================================
  // 🎪 FOCUS RING (for accessibility)
  // ========================================

  /// Focus indicator shadow
  static List<BoxShadow> get focus => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.5),
          blurRadius: 0,
          spreadRadius: 3,
        ),
      ];

  // ========================================
  // 📱 BOTTOM SHEET SHADOW
  // ========================================

  /// Shadow for bottom sheets
  static List<BoxShadow> get bottomSheet => [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 40,
          offset: const Offset(0, -4),
        ),
      ];

  // ========================================
  // 🎯 APP BAR SHADOW
  // ========================================

  /// Shadow for app bars
  static List<BoxShadow> get appBar => [
        BoxShadow(
          color: AppColorsV2.roseQuartz.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
}
