# Fridge Tracker - Implementation Guide
## Step-by-Step Cute UI/UX Implementation

---

## PHASE 1: FOUNDATION (Days 1-3)

### Step 1.1: Update Dependencies

**File:** `d:\fridge_tracker\pubspec.yaml`

Add these new dependencies:

```yaml
dependencies:
  # Existing packages...
  google_fonts: ^6.1.0  # Already exists

  # New packages for cute UI
  flutter_animate: ^4.5.0        # Smooth animations
  shimmer: ^3.0.0                # Loading effects
  flutter_svg: ^2.0.9            # Vector graphics

dev_dependencies:
  # Existing...
```

**Commands to run:**
```bash
cd d:\fridge_tracker
flutter pub add flutter_animate
flutter pub add shimmer
flutter pub add flutter_svg
flutter pub get
```

---

### Step 1.2: Create New Color Constants

**File:** `d:\fridge_tracker\lib\utils\app_colors.dart` (NEW)

```dart
import 'package:flutter/material.dart';

/// Cute & Feminine Color Palette for Fridge Tracker
class AppColors {
  AppColors._(); // Private constructor

  // ===== PRIMARY COLORS =====
  static const Color primaryPink = Color(0xFFFFB6C1);
  static const Color primaryLavender = Color(0xFFE6E6FA);
  static const Color primaryMint = Color(0xFFB4E7CE);
  static const Color primaryPeach = Color(0xFFFFDAB9);
  static const Color primaryLilac = Color(0xFFDDA0DD);

  // ===== ACCENT COLORS =====
  static const Color accentRose = Color(0xFFFF69B4);
  static const Color accentCoral = Color(0xFFFF7F7F);
  static const Color accentSky = Color(0xFFADD8E6);
  static const Color accentLemon = Color(0xFFFFF4B0);

  // ===== STATUS COLORS =====

  // Fresh Status (Mint Green)
  static const Color freshPrimary = Color(0xFF98D8C8);
  static const Color freshSecondary = Color(0xFF7CC9B5);
  static const Color freshBg = Color(0xFFE8F5F1);
  static const Color freshBorder = Color(0xFFB4E7CE);

  // Warning Status (Peach/Orange)
  static const Color warnPrimary = Color(0xFFFFB88C);
  static const Color warnSecondary = Color(0xFFFF9A6C);
  static const Color warnBg = Color(0xFFFFF3E0);
  static const Color warnBorder = Color(0xFFFFDAB9);

  // Expired Status (Coral/Red)
  static const Color expiredPrimary = Color(0xFFFF9999);
  static const Color expiredSecondary = Color(0xFFFF7777);
  static const Color expiredBg = Color(0xFFFFE6E6);
  static const Color expiredBorder = Color(0xFFFFCCCC);

  // ===== NEUTRAL COLORS =====
  static const Color white = Color(0xFFFFFFFF);
  static const Color cream = Color(0xFFFFFBF5);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF9E9E9E);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF9E9E9E);

  // ===== GRADIENTS =====

  static const LinearGradient headerGradient = LinearGradient(
    colors: [primaryPink, primaryLavender],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [cream, Color(0xFFFFF8F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [primaryPink, accentRose],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient freshGradient = LinearGradient(
    colors: [freshPrimary, freshSecondary],
  );

  static const LinearGradient warnGradient = LinearGradient(
    colors: [warnPrimary, warnSecondary],
  );

  static const LinearGradient expiredGradient = LinearGradient(
    colors: [expiredPrimary, expiredSecondary],
  );

  static const LinearGradient lavenderGradient = LinearGradient(
    colors: [primaryLavender, primaryLilac],
  );

  // ===== HELPER METHODS =====

  /// Get status gradient based on expiry status
  static LinearGradient getStatusGradient(String status) {
    switch (status.toLowerCase()) {
      case 'fresh':
        return freshGradient;
      case 'expiringsoon':
      case 'warning':
        return warnGradient;
      case 'expired':
        return expiredGradient;
      default:
        return buttonGradient;
    }
  }

  /// Get status primary color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'fresh':
        return freshPrimary;
      case 'expiringsoon':
      case 'warning':
        return warnPrimary;
      case 'expired':
        return expiredPrimary;
      default:
        return primaryPink;
    }
  }
}
```

---

### Step 1.3: Create Typography System

**File:** `d:\fridge_tracker\lib\utils\app_typography.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system for Fridge Tracker
class AppTypography {
  AppTypography._(); // Private constructor

  // ===== DISPLAY TEXT =====
  static TextStyle display = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // ===== HEADINGS =====
  static TextStyle h1 = GoogleFonts.quicksand(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static TextStyle h2 = GoogleFonts.quicksand(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle h3 = GoogleFonts.quicksand(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle h4 = GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ===== BODY TEXT =====
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // ===== LABELS =====
  static TextStyle labelLarge = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.2,
  );

  static TextStyle labelMedium = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
  );

  static TextStyle labelSmall = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
  );

  // ===== BUTTON TEXT =====
  static TextStyle button = GoogleFonts.quicksand(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle buttonLarge = GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // ===== CAPTION =====
  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
}
```

---

### Step 1.4: Create Spacing System

**File:** `d:\fridge_tracker\lib\utils\app_spacing.dart` (NEW)

```dart
/// Spacing system based on 8pt grid
class Spacing {
  Spacing._();

  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

/// Border radius values
class BorderRadii {
  BorderRadii._();

  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 28.0;
  static const double pill = 999.0;
}
```

---

### Step 1.5: Create Shadow System

**File:** `d:\fridge_tracker\lib\utils\app_shadows.dart` (NEW)

```dart
import 'package:flutter/material.dart';

/// Shadow system for consistent elevation
class AppShadows {
  AppShadows._();

  // ===== SOFT ELEVATION (Cards) =====
  static List<BoxShadow> soft = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      offset: const Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.02),
      offset: const Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  // ===== MEDIUM ELEVATION (Floating elements) =====
  static List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  // ===== STRONG ELEVATION (FAB, Modals) =====
  static List<BoxShadow> strong = [
    BoxShadow(
      color: const Color(0xFFFFB6C1).withOpacity(0.3),
      offset: const Offset(0, 6),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      offset: const Offset(0, 10),
      blurRadius: 30,
      spreadRadius: 0,
    ),
  ];

  // ===== COLORED SHADOWS =====
  static List<BoxShadow> coloredShadow(Color color, {double opacity = 0.3}) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        offset: const Offset(0, 6),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }

  // ===== TOP SHADOW (For bottom bars) =====
  static List<BoxShadow> topShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, -4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
}
```

---

### Step 1.6: Update Main Theme

**File:** `d:\fridge_tracker\lib\utils\constants.dart` (UPDATE)

Replace the existing `AppTheme` class:

```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

// ... existing AppConstants class stays the same ...

// NEW Theme class
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // ===== COLOR SCHEME =====
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryPink,
        secondary: AppColors.primaryLavender,
        tertiary: AppColors.primaryMint,
        surface: AppColors.cream,
        background: AppColors.white,
        error: AppColors.expiredPrimary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textDark,
        onBackground: AppColors.textDark,
      ),

      // ===== SCAFFOLD =====
      scaffoldBackgroundColor: AppColors.white,

      // ===== APP BAR =====
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.h2.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ===== CARD =====
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.white,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.lg),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.xs,
        ),
      ),

      // ===== INPUT DECORATION =====
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BorderRadii.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BorderRadii.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BorderRadii.md),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.primaryPink,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BorderRadii.md),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.expiredPrimary,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.lg,
          vertical: Spacing.md,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textLight,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textLight,
        ),
      ),

      // ===== FLOATING ACTION BUTTON =====
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 8,
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.xxl),
        ),
      ),

      // ===== ELEVATED BUTTON =====
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primaryPink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.lg,
            vertical: Spacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadii.pill),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // ===== TEXT BUTTON =====
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryPink,
          textStyle: AppTypography.button,
        ),
      ),

      // ===== OUTLINED BUTTON =====
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryPink,
          side: const BorderSide(
            color: AppColors.primaryPink,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.lg,
            vertical: Spacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadii.pill),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // ===== DIVIDER =====
      dividerTheme: const DividerThemeData(
        color: AppColors.mediumGray,
        thickness: 1,
        space: 1,
      ),

      // ===== ICON THEME =====
      iconTheme: const IconThemeData(
        color: AppColors.textDark,
        size: 24,
      ),

      // ===== TEXT THEME =====
      textTheme: TextTheme(
        displayLarge: AppTypography.display,
        displayMedium: AppTypography.h1,
        displaySmall: AppTypography.h2,
        headlineLarge: AppTypography.h1,
        headlineMedium: AppTypography.h2,
        headlineSmall: AppTypography.h3,
        titleLarge: AppTypography.h3,
        titleMedium: AppTypography.h4,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ),
    );
  }

  // Dark theme (optional - can implement later)
  static ThemeData get darkTheme {
    // For now, return light theme
    // Can implement proper dark theme later
    return lightTheme;
  }
}
```

---

## PHASE 2: REUSABLE COMPONENTS (Days 4-7)

### Step 2.1: Create Cute Button Component

**File:** `d:\fridge_tracker\lib\widgets\cute\cute_button.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_shadows.dart';

enum CuteButtonType {
  primary,    // Gradient button
  secondary,  // Outlined button
  text,       // Text button
}

enum CuteButtonSize {
  small,   // Height 40
  medium,  // Height 48
  large,   // Height 52
}

class CuteButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final CuteButtonType type;
  final CuteButtonSize size;
  final double? width;
  final LinearGradient? customGradient;

  const CuteButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.type = CuteButtonType.primary,
    this.size = CuteButtonSize.large,
    this.width,
    this.customGradient,
  });

  @override
  Widget build(BuildContext context) {
    final height = _getHeight();
    final padding = _getPadding();
    final disabled = onPressed == null || isLoading;

    switch (type) {
      case CuteButtonType.primary:
        return _buildPrimaryButton(height, padding, disabled);
      case CuteButtonType.secondary:
        return _buildSecondaryButton(height, padding, disabled);
      case CuteButtonType.text:
        return _buildTextButton(height, padding, disabled);
    }
  }

  // Primary button with gradient
  Widget _buildPrimaryButton(double height, EdgeInsets padding, bool disabled) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: disabled
            ? const LinearGradient(colors: [Colors.grey, Colors.grey])
            : (customGradient ?? AppColors.buttonGradient),
        borderRadius: BorderRadius.circular(BorderRadii.pill),
        boxShadow: disabled ? [] : AppShadows.medium,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onPressed,
          borderRadius: BorderRadius.circular(BorderRadii.pill),
          child: Padding(
            padding: padding,
            child: _buildContent(Colors.white),
          ),
        ),
      ),
    );
  }

  // Secondary button with outline
  Widget _buildSecondaryButton(double height, EdgeInsets padding, bool disabled) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: disabled ? Colors.grey : AppColors.primaryPink,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(BorderRadii.pill),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onPressed,
          borderRadius: BorderRadius.circular(BorderRadii.pill),
          child: Padding(
            padding: padding,
            child: _buildContent(
              disabled ? Colors.grey : AppColors.primaryPink,
            ),
          ),
        ),
      ),
    );
  }

  // Text button
  Widget _buildTextButton(double height, EdgeInsets padding, bool disabled) {
    return Container(
      height: height,
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onPressed,
          borderRadius: BorderRadius.circular(BorderRadii.pill),
          child: Padding(
            padding: padding,
            child: _buildContent(
              disabled ? Colors.grey : AppColors.primaryPink,
            ),
          ),
        ),
      ),
    );
  }

  // Button content (icon + text + loader)
  Widget _buildContent(Color color) {
    return Row(
      mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && !isLoading) ...[
          Icon(icon, color: color, size: _getIconSize()),
          const SizedBox(width: Spacing.xs),
        ],
        if (isLoading)
          SizedBox(
            width: _getIconSize(),
            height: _getIconSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        if (!isLoading)
          Text(
            label,
            style: _getTextStyle().copyWith(color: color),
          ),
      ],
    );
  }

  // Helper methods
  double _getHeight() {
    switch (size) {
      case CuteButtonSize.small:
        return 40;
      case CuteButtonSize.medium:
        return 48;
      case CuteButtonSize.large:
        return 52;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case CuteButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: Spacing.md);
      case CuteButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: Spacing.lg);
      case CuteButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: Spacing.xl);
    }
  }

  double _getIconSize() {
    switch (size) {
      case CuteButtonSize.small:
        return 16;
      case CuteButtonSize.medium:
        return 18;
      case CuteButtonSize.large:
        return 20;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case CuteButtonSize.small:
        return AppTypography.labelLarge;
      case CuteButtonSize.medium:
      case CuteButtonSize.large:
        return AppTypography.button;
    }
  }
}
```

---

### Step 2.2: Create Cute Text Field Component

**File:** `d:\fridge_tracker\lib\widgets\cute\cute_text_field.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';

class CuteTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;

  const CuteTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<CuteTextField> createState() => _CuteTextFieldState();
}

class _CuteTextFieldState extends State<CuteTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.enabled ? AppColors.cream : AppColors.lightGray,
        borderRadius: BorderRadius.circular(BorderRadii.md),
        border: Border.all(
          color: _isFocused ? AppColors.primaryPink : Colors.transparent,
          width: 2,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primaryPink.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        validator: widget.validator,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textDark,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textLight,
          ),
          floatingLabelStyle: AppTypography.labelMedium.copyWith(
            color: AppColors.primaryPink,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textLight.withOpacity(0.5),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(Spacing.sm),
                  child: Icon(
                    widget.prefixIcon,
                    color: _isFocused
                        ? AppColors.primaryPink
                        : AppColors.textLight,
                    size: 22,
                  ),
                )
              : null,
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: widget.prefixIcon == null ? Spacing.md : 0,
            vertical: Spacing.md,
          ),
        ),
        onTap: () => setState(() => _isFocused = true),
        onTapOutside: (_) => setState(() => _isFocused = false),
      ),
    );
  }
}
```

---

### Step 2.3: Create Section Header Widget

**File:** `d:\fridge_tracker\lib\widgets\cute\section_header.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String emoji;
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.emoji,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.md,
        Spacing.lg,
        Spacing.md,
        Spacing.md,
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: Spacing.xs),
          Text(
            title,
            style: AppTypography.h3.copyWith(color: AppColors.textDark),
          ),
          const SizedBox(width: Spacing.sm),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryPink.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: Spacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
```

---

### Step 2.4: Export All Cute Widgets

**File:** `d:\fridge_tracker\lib\widgets\cute\cute_widgets.dart` (NEW)

```dart
/// Export all cute UI components
library cute_widgets;

export 'cute_button.dart';
export 'cute_text_field.dart';
export 'section_header.dart';
// Add more exports as we create more components
```

---

## PHASE 3: UPDATE EXISTING WIDGETS (Days 8-10)

### Step 3.1: Update Expiry Badge

**File:** `d:\fridge_tracker\lib\widgets\expiry_badge.dart` (UPDATE)

Replace the entire file with this cute version:

```dart
import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';
import '../utils/app_spacing.dart';
import '../utils/app_shadows.dart';
import '../utils/date_utils.dart';

class ExpiryBadge extends StatelessWidget {
  final FoodItem food;
  final bool showIcon;

  const ExpiryBadge({
    super.key,
    required this.food,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final status = food.expiryStatus;
    final days = food.daysUntilExpiry;

    LinearGradient gradient;
    String emoji;
    String text;

    switch (status) {
      case ExpiryStatus.expired:
        gradient = AppColors.expiredGradient;
        emoji = '⚠️';
        text = AppDateUtils.getDaysRemainingText(days);
        break;
      case ExpiryStatus.expiringSoon:
        gradient = AppColors.warnGradient;
        emoji = '⏳';
        text = AppDateUtils.getDaysRemainingText(days);
        break;
      case ExpiryStatus.fresh:
        gradient = AppColors.freshGradient;
        emoji = '✨';
        text = AppDateUtils.getDaysRemainingText(days);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.xs + 2,
        vertical: Spacing.xxs,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(BorderRadii.sm),
        boxShadow: AppShadows.coloredShadow(
          AppColors.getStatusColor(status.name),
          opacity: 0.3,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Text(
              emoji,
              style: const TextStyle(fontSize: 11),
            ),
            const SizedBox(width: Spacing.xxs),
          ],
          Text(
            text,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Large badge for detail screen
class LargeExpiryBadge extends StatelessWidget {
  final FoodItem food;

  const LargeExpiryBadge({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final status = food.expiryStatus;
    final days = food.daysUntilExpiry;

    LinearGradient gradient;
    String emoji;
    String title;
    String subtitle;

    switch (status) {
      case ExpiryStatus.expired:
        gradient = AppColors.expiredGradient;
        emoji = '⚠️';
        title = 'Đã hết hạn';
        subtitle = days == 0 ? 'Hôm nay' : '${-days} ngày trước';
        break;
      case ExpiryStatus.expiringSoon:
        gradient = AppColors.warnGradient;
        emoji = '⏳';
        title = 'Sắp hết hạn';
        subtitle = days == 0
            ? 'Hôm nay'
            : days == 1
                ? 'Ngày mai'
                : 'Còn $days ngày';
        break;
      case ExpiryStatus.fresh:
        gradient = AppColors.freshGradient;
        emoji = '✨';
        title = 'Còn hạn';
        subtitle = 'Còn $days ngày';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.lg,
        vertical: Spacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(BorderRadii.lg),
        boxShadow: AppShadows.coloredShadow(
          AppColors.getStatusColor(status.name),
          opacity: 0.4,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: Spacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTypography.h4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

## NEXT STEPS

After completing Phase 1-3, you should have:
- New color system
- Typography system
- Spacing & shadows
- Updated theme
- Reusable cute components (button, text field, headers)
- Updated expiry badge

**Continue to IMPLEMENTATION_GUIDE_PART2.md for:**
- Phase 4: Update Food Card
- Phase 5: Update Home Screen
- Phase 6: Update Add/Edit Screen
- Phase 7: Update Detail Screen
- Phase 8: Animations & Polish

---

## TESTING CHECKLIST

After each phase, test:
- [ ] Hot reload works
- [ ] No build errors
- [ ] Theme applies correctly
- [ ] Colors look good
- [ ] Typography is readable
- [ ] Spacing feels comfortable
- [ ] Components are reusable
- [ ] Animations are smooth (later phases)

---

## TROUBLESHOOTING

### Common Issues:

1. **Import errors**: Make sure file paths are correct
2. **Theme not applying**: Check main.dart uses AppTheme.lightTheme
3. **Google Fonts not loading**: Run `flutter pub get`
4. **Colors look different**: Check device brightness settings
5. **Hot reload fails**: Try hot restart (Shift + R in terminal)

---

## COMMIT STRATEGY

Commit after each major step:
```bash
git add .
git commit -m "feat: add color system and typography"
git commit -m "feat: create cute button component"
git commit -m "feat: update theme with cute design"
# etc.
```
