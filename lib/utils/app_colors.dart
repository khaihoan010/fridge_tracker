import 'package:flutter/material.dart';

/// Neumorphic Unicorn Color Palette - Rainbow Pastels 🦄✨
class AppColors {
  // Primary Colors - Unicorn Rainbow Pastels
  static const Color primaryPink = Color(0xFFFFB3D9); // Unicorn Pink
  static const Color primaryLavender = Color(0xFFDEC9FF); // Unicorn Purple
  static const Color primaryMint = Color(0xFFAEE8D4); // Unicorn Mint
  static const Color primaryPeach = Color(0xFFFFD4B8); // Unicorn Peach
  static const Color primaryCream = Color(0xFFFFF5E6); // Unicorn Cream
  static const Color primarySky = Color(0xFFB8E2FF); // Unicorn Sky Blue
  static const Color primaryYellow = Color(0xFFFFF8B8); // Unicorn Yellow

  // Neumorphic Background - Light pastel base for embossed effect
  static const Color backgroundNeu = Color(0xFFF0ECF8); // Soft lavender-gray base
  static const Color backgroundLight = Color(0xFFF5F2FB); // Very light lavender
  static const Color backgroundCard = Color(0xFFF0ECF8); // Same as backgroundNeu for neumorphic effect
  static const Color backgroundAccent = Color(0xFFFFF0F8); // Light pink tint

  // Text Colors
  static const Color textPrimary = Color(0xFF2D2D2D); // Soft Black
  static const Color textSecondary = Color(0xFF757575); // Medium Gray
  static const Color textLight = Color(0xFFB0B0B0); // Light Gray
  static const Color textWhite = Color(0xFFFFFFFF); // White

  // Status Colors - Soft Versions
  static const Color statusFresh = Color(0xFFB4E7CE); // Mint (Fresh)
  static const Color statusWarning = Color(0xFFFFCBA4); // Peach (Warning)
  static const Color statusExpired = Color(0xFFFFA5A5); // Soft Coral (Expired)

  // Accent Colors
  static const Color accentHeart = Color(0xFFFF69B4); // Hot Pink
  static const Color accentStar = Color(0xFFFFD700); // Gold
  static const Color accentSparkle = Color(0xFFDDA0DD); // Plum

  // Shadow Colors
  static const Color shadowSoft = Color(0x1AFFB6C1); // Soft Pink Shadow (10% opacity)
  static const Color shadowCard = Color(0x0A000000); // Card Shadow (4% opacity)

  // Unicorn Rainbow Gradients 🌈
  static const List<Color> gradientUnicorn = [
    primaryPink,
    primaryLavender,
    primarySky,
    primaryMint,
  ]; // Full rainbow
  static const List<Color> gradientPinkLavender = [primaryPink, primaryLavender];
  static const List<Color> gradientMintPeach = [primaryMint, primaryPeach];
  static const List<Color> gradientPeachCream = [primaryPeach, primaryCream];
  static const List<Color> gradientSkyMint = [primarySky, primaryMint];

  // Category Gradients - Unicorn themed
  static const Map<String, List<Color>> categoryGradients = {
    'vegetables': [Color(0xFFAEE8D4), Color(0xFF92DFC0)], // Unicorn mint gradient
    'fruits': [Color(0xFFFFD4B8), Color(0xFFFFBFA0)], // Unicorn peach gradient
    'meat': [Color(0xFFFFB3D9), Color(0xFFFF9AC7)], // Unicorn pink gradient
    'seafood': [Color(0xFFB8E2FF), Color(0xFF9AD4FF)], // Unicorn sky blue gradient
    'dairy': [Color(0xFFFFF5E6), Color(0xFFFFE8CC)], // Unicorn cream gradient
    'beverages': [Color(0xFFDEC9FF), Color(0xFFC9B3FF)], // Unicorn lavender gradient
    'frozen': [Color(0xFFB8E2FF), Color(0xFF9AD4FF)], // Unicorn sky gradient
    'snacks': [Color(0xFFFFF8B8), Color(0xFFFFECA0)], // Unicorn yellow gradient
    'others': [Color(0xFFE8E2F0), Color(0xFFD4CCE0)], // Soft gray-purple gradient
  };

  // Helper: Get gradient for category
  static List<Color> getCategoryGradient(String categoryId) {
    return categoryGradients[categoryId] ?? categoryGradients['others']!;
  }

  // Helper: Get status color based on days remaining
  static Color getStatusColor(int daysRemaining) {
    if (daysRemaining < 0) return statusExpired;
    if (daysRemaining <= 3) return statusWarning;
    return statusFresh;
  }
}
