import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Neumorphic Shadow System 🦄✨
/// Creates embossed/debossed 3D effects with dual light/dark shadows
class AppShadows {
  // Neumorphic Embossed Effect (raised/convex)
  // Light source from top-left creates highlight on top-left, shadow on bottom-right
  static List<BoxShadow> neuEmbossed = [
    // Light shadow (highlight) - top-left
    const BoxShadow(
      color: Color(0xFFFFFFFF), // White highlight
      blurRadius: 10,
      spreadRadius: -2,
      offset: Offset(-6, -6),
    ),
    // Dark shadow - bottom-right
    BoxShadow(
      color: const Color(0xFFD4C4E8).withValues(alpha: 0.6), // Soft purple shadow
      blurRadius: 10,
      spreadRadius: -2,
      offset: const Offset(6, 6),
    ),
  ];

  // Neumorphic Debossed Effect (pressed/concave)
  // Inverted shadows create inset appearance
  static List<BoxShadow> neuDebossed = [
    // Dark shadow - top-left (appears inside)
    BoxShadow(
      color: const Color(0xFFD4C4E8).withValues(alpha: 0.5),
      blurRadius: 8,
      spreadRadius: -1,
      offset: const Offset(-4, -4),
    ),
    // Light shadow - bottom-right
    const BoxShadow(
      color: Color(0x40FFFFFF),
      blurRadius: 8,
      spreadRadius: -1,
      offset: Offset(4, 4),
    ),
  ];

  // Soft neumorphic for subtle elements
  static List<BoxShadow> neuSoft = [
    const BoxShadow(
      color: Color(0xFFFFFFFF),
      blurRadius: 6,
      spreadRadius: -1,
      offset: Offset(-3, -3),
    ),
    BoxShadow(
      color: const Color(0xFFD4C4E8).withValues(alpha: 0.4),
      blurRadius: 6,
      spreadRadius: -1,
      offset: const Offset(3, 3),
    ),
  ];

  // Strong neumorphic for prominent elements (buttons, FAB)
  static List<BoxShadow> neuStrong = [
    const BoxShadow(
      color: Color(0xFFFFFFFF),
      blurRadius: 15,
      spreadRadius: -3,
      offset: Offset(-8, -8),
    ),
    BoxShadow(
      color: const Color(0xFFD4C4E8).withValues(alpha: 0.7),
      blurRadius: 15,
      spreadRadius: -3,
      offset: const Offset(8, 8),
    ),
  ];

  // Flat shadow for non-neumorphic elements
  static List<BoxShadow> flat = [
    BoxShadow(
      color: const Color(0xFFD4C4E8).withValues(alpha: 0.3),
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];

  // Legacy shadows (backward compatibility)
  static List<BoxShadow> soft = neuSoft;
  static List<BoxShadow> card = neuEmbossed;
  static List<BoxShadow> elevated = neuStrong;

  // Colored shadows for gradient elements
  static List<BoxShadow> coloredShadow(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.4),
        blurRadius: 12,
        spreadRadius: 0,
        offset: const Offset(0, 6),
      ),
    ];
  }

  // Inner shadow effect (for inputs) - using debossed
  static List<BoxShadow> inner = neuDebossed;
}
