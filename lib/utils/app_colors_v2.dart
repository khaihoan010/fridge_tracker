import 'package:flutter/material.dart';

/// 🌸 Feminine & Modern Color System
/// Design for young women - soft, elegant, delightful
class AppColorsV2 {
  // ========================================
  // 🌸 PRIMARY COLORS - Feminine Pastels
  // ========================================

  /// Rose Quartz - Main brand color
  static const Color roseQuartz = Color(0xFFFFD6E8);

  /// Lavender Mist - Secondary brand
  static const Color lavenderMist = Color(0xFFE8D5F2);

  /// Mint Cream - Success/Fresh
  static const Color mintCream = Color(0xFFD5F2E3);

  /// Peach Blossom - Warning
  static const Color peachBlossom = Color(0xFFFFE4D6);

  /// Coral Blush - Error/Expired
  static const Color coralBlush = Color(0xFFFFD4D4);

  // ========================================
  // 🤍 NEUTRAL COLORS - Clean & Elegant
  // ========================================

  static const Color snowWhite = Color(0xFFFAFBFC);
  static const Color pearlGray = Color(0xFFF5F7FA);
  static const Color doveGray = Color(0xFFE8EAED);
  static const Color silverCloud = Color(0xFFC4C9D0);
  static const Color charcoalSoft = Color(0xFF4A5568);
  static const Color slateMuted = Color(0xFF718096);

  // ========================================
  // ✨ ACCENT COLORS - Delightful Touches
  // ========================================

  static const Color goldenHour = Color(0xFFFFE5B4);
  static const Color skySoft = Color(0xFFD6E8FF);
  static const Color mintFresh = Color(0xFFB4F0D7);

  // ========================================
  // 🎨 GRADIENTS - Dreamy & Romantic
  // ========================================

  /// Primary gradient - Rose to Lavender
  static const List<Color> gradientPrimary = [
    roseQuartz,
    lavenderMist,
  ];

  /// Success gradient - Mint shades
  static const List<Color> gradientSuccess = [
    mintCream,
    mintFresh,
  ];

  /// Warning gradient - Peach shades
  static const List<Color> gradientWarning = [
    peachBlossom,
    Color(0xFFFFD6C4),
  ];

  /// Sunset gradient - Multi-color
  static const List<Color> gradientSunset = [
    goldenHour,
    roseQuartz,
    lavenderMist,
  ];

  /// Card gradient - Subtle depth
  static const List<Color> gradientCard = [
    snowWhite,
    pearlGray,
  ];

  // ========================================
  // 📦 CATEGORY COLORS - Food Types
  // ========================================

  static const Map<String, Color> categoryColors = {
    'vegetables': Color(0xFFB4E8D7), // Soft mint
    'fruits': Color(0xFFFFD1DC), // Baby pink
    'meat': Color(0xFFFFB8C6), // Rose
    'seafood': Color(0xFFAFD8FF), // Sky blue
    'dairy': Color(0xFFFFF5E1), // Cream
    'beverages': Color(0xFFDEC9FF), // Lavender
    'frozen': Color(0xFFBFE8FF), // Ice blue
    'bakery': Color(0xFFFFE4B8), // Wheat
    'condiments': Color(0xFFFFD4A3), // Honey
    'others': Color(0xFFE8D5E8), // Soft purple
  };

  static const Map<String, List<Color>> categoryGradients = {
    'vegetables': [Color(0xFFD5F2E3), Color(0xFFB4E8D7)],
    'fruits': [Color(0xFFFFE1E8), Color(0xFFFFD1DC)],
    'meat': [Color(0xFFFFD1DC), Color(0xFFFFB8C6)],
    'seafood': [Color(0xFFD6E8FF), Color(0xFFAFD8FF)],
    'dairy': [Color(0xFFFFFAEB), Color(0xFFFFF5E1)],
    'beverages': [Color(0xFFE8D5F2), Color(0xFFDEC9FF)],
    'frozen': [Color(0xFFD6F0FF), Color(0xFFBFE8FF)],
    'bakery': [Color(0xFFFFEFD1), Color(0xFFFFE4B8)],
    'condiments': [Color(0xFFFFE1BA), Color(0xFFFFD4A3)],
    'others': [Color(0xFFF0E8F0), Color(0xFFE8D5E8)],
  };

  // ========================================
  // 🏷️ STATUS COLORS - Expiry States
  // ========================================

  /// Fresh items (3+ days remaining)
  static const Color statusFreshBg = mintCream;
  static const Color statusFreshBorder = mintFresh;
  static const Color statusFreshText = Color(0xFF2D6854);

  /// Expiring soon (1-3 days)
  static const Color statusWarnBg = peachBlossom;
  static const Color statusWarnBorder = Color(0xFFFFD6C4);
  static const Color statusWarnText = Color(0xFF8B5A3C);

  /// Expired (0 days)
  static const Color statusExpiredBg = coralBlush;
  static const Color statusExpiredBorder = Color(0xFFFFC0C0);
  static const Color statusExpiredText = Color(0xFF8B3A3A);

  // ========================================
  // 🎨 HELPER FUNCTIONS
  // ========================================

  /// Get category color by ID
  static Color getCategoryColor(String categoryId) {
    return categoryColors[categoryId] ?? categoryColors['others']!;
  }

  /// Get category gradient by ID
  static List<Color> getCategoryGradient(String categoryId) {
    return categoryGradients[categoryId] ?? categoryGradients['others']!;
  }

  /// Get status colors based on days remaining
  static Map<String, Color> getStatusColors(int daysRemaining) {
    if (daysRemaining < 0) {
      return {
        'background': statusExpiredBg,
        'border': statusExpiredBorder,
        'text': statusExpiredText,
      };
    } else if (daysRemaining <= 3) {
      return {
        'background': statusWarnBg,
        'border': statusWarnBorder,
        'text': statusWarnText,
      };
    } else {
      return {
        'background': statusFreshBg,
        'border': statusFreshBorder,
        'text': statusFreshText,
      };
    }
  }

  /// Get status emoji
  static String getStatusEmoji(int daysRemaining) {
    if (daysRemaining < 0) return '❌';
    if (daysRemaining <= 3) return '⚠️';
    return '✨';
  }
}
