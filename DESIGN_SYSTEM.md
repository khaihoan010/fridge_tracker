# Fridge Tracker - Design System
## Cute & Feminine UI/UX Design

---

## 1. COLOR PALETTE

### Primary Colors
```dart
// Soft Pastels - Main Palette
static const Color primaryPink = Color(0xFFFFB6C1);        // Light Pink
static const Color primaryLavender = Color(0xFFE6E6FA);    // Lavender
static const Color primaryMint = Color(0xFFB4E7CE);        // Mint Green
static const Color primaryPeach = Color(0xFFFFDAB9);       // Peach
static const Color primaryLilac = Color(0xFFDDA0DD);       // Plum/Lilac

// Accent Colors
static const Color accentRose = Color(0xFFFF69B4);         // Hot Pink
static const Color accentCoral = Color(0xFFFF7F7F);        // Coral
static const Color accentSky = Color(0xFFADD8E6);          // Light Blue
static const Color accentLemon = Color(0xFFFFF4B0);        // Lemon Yellow
```

### Status Colors (Pastel Versions)
```dart
// Fresh - Mint/Green
static const Color freshPrimary = Color(0xFF98D8C8);       // Mint
static const Color freshBg = Color(0xFFE8F5F1);
static const Color freshBorder = Color(0xFFB4E7CE);

// Expiring Soon - Peach/Orange
static const Color warnPrimary = Color(0xFFFFB88C);        // Soft Peach
static const Color warnBg = Color(0xFFFFF3E0);
static const Color warnBorder = Color(0xFFFFDAB9);

// Expired - Pink/Red
static const Color expiredPrimary = Color(0xFFFF9999);     // Light Coral
static const Color expiredBg = Color(0xFFFFE6E6);
static const Color expiredBorder = Color(0xFFFFCCCC);
```

### Neutral Colors
```dart
static const Color white = Color(0xFFFFFFFF);
static const Color cream = Color(0xFFFFFBF5);              // Warm White
static const Color lightGray = Color(0xFFF5F5F5);
static const Color mediumGray = Color(0xFFE0E0E0);
static const Color textDark = Color(0xFF4A4A4A);
static const Color textLight = Color(0xFF9E9E9E);
```

### Gradient Combinations
```dart
// Header Gradient
static const LinearGradient headerGradient = LinearGradient(
  colors: [Color(0xFFFFB6C1), Color(0xFFE6E6FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Card Gradient (Subtle)
static const LinearGradient cardGradient = LinearGradient(
  colors: [Color(0xFFFFFBF5), Color(0xFFFFF8F0)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// Button Gradient
static const LinearGradient buttonGradient = LinearGradient(
  colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
```

---

## 2. TYPOGRAPHY

### Google Fonts Selection
```dart
import 'package:google_fonts/google_fonts.dart';

// Primary Font: Quicksand (Rounded, friendly, cute)
static TextStyle headingFont = GoogleFonts.quicksand(
  fontWeight: FontWeight.bold,
);

// Body Font: Poppins (Clean, modern, readable)
static TextStyle bodyFont = GoogleFonts.poppins();

// Alternative: Nunito (Softer, more playful)
static TextStyle alternativeFont = GoogleFonts.nunito();
```

### Type Scale
```dart
class AppTypography {
  // Display - App Name, Large Headers
  static TextStyle display = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // Heading 1 - Screen Titles
  static TextStyle h1 = GoogleFonts.quicksand(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.3,
  );

  // Heading 2 - Section Headers
  static TextStyle h2 = GoogleFonts.quicksand(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Heading 3 - Card Titles
  static TextStyle h3 = GoogleFonts.quicksand(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Body Large
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Body Medium
  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Body Small
  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // Label/Caption
  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
  );

  // Button Text
  static TextStyle button = GoogleFonts.quicksand(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
```

---

## 3. SPACING & LAYOUT

### Spacing System (8pt Grid)
```dart
class Spacing {
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}
```

### Border Radius (Rounded Corners)
```dart
class BorderRadii {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double xlarge = 28.0;
  static const double pill = 999.0;  // For fully rounded buttons
}
```

### Shadows (Soft, Subtle)
```dart
class Shadows {
  // Soft elevation for cards
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

  // Medium elevation for floating elements
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

  // Strong elevation for FAB and modals
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
}
```

---

## 4. COMPONENT DESIGNS

### 4.1 Buttons

#### Primary Button (Gradient with Shadow)
```dart
class CuteButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;

  const CuteButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: Shadows.medium,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(26),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null && !isLoading) ...[
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                ],
                if (isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                if (!isLoading)
                  Text(
                    label,
                    style: AppTypography.button.copyWith(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

#### Secondary Button (Outlined)
```dart
class CuteOutlinedButton extends StatelessWidget {
  // Soft outline with pastel colors
  // Border: 2px solid primaryPink
  // Background: white
  // Text: primaryPink
  // Hover: light pink background
}
```

#### Icon Button (Rounded)
```dart
class CuteIconButton extends StatelessWidget {
  // Circular button
  // Size: 44x44
  // Background: light pastel
  // Icon: darker shade
  // Shadow: soft
}
```

### 4.2 Cards

#### Food Card (Enhanced)
```dart
class CuteFoodCard extends StatelessWidget {
  // Design:
  // - White background with soft shadow
  // - Border radius: 20
  // - Padding: 16
  // - Image: rounded 16, with gradient overlay
  // - Badge: floating on top-right of image
  // - Title: bold, 18px
  // - Category chip: pill-shaped with icon
  // - Expiry info: with cute icon
  // - Swipe actions: smooth reveal
}
```

**Layout Structure:**
```
┌──────────────────────────────────┐
│  ┌────────┐                      │
│  │        │  Food Name           │
│  │ Image  │  🥗 Category         │
│  │   🎫   │  📍 Location         │
│  │        │  ⏰ Còn 5 ngày       │
│  └────────┘                      │
└──────────────────────────────────┘
```

### 4.3 Input Fields

#### Cute Text Field
```dart
class CuteTextField extends StatelessWidget {
  // Design:
  // - Background: light cream (F5F5F5)
  // - Border: none (when unfocused)
  // - Focused border: 2px gradient
  // - Border radius: 16
  // - Height: 56
  // - Prefix icon: pastel colored
  // - Label: floating with smooth animation
  // - Cursor: pink
}
```

#### Dropdown (Custom Design)
```dart
class CuteDropdown extends StatelessWidget {
  // Design:
  // - Same style as text field
  // - Custom dropdown panel with rounded corners
  // - Checkmark icon for selected item
  // - Smooth expand/collapse animation
  // - Each item with icon and text
}
```

### 4.4 Badges & Chips

#### Status Badge (Redesigned)
```dart
class CuteExpiryBadge extends StatelessWidget {
  // Fresh: Mint green background, white text, sparkle icon ✨
  // Warning: Peach background, white text, hourglass icon ⏳
  // Expired: Soft coral background, white text, alert icon ⚠️

  // Design:
  // - Pill shape (height: 28)
  // - Icon + text
  // - Soft shadow
  // - Subtle gradient
}
```

#### Category Chip
```dart
class CategoryChip extends StatelessWidget {
  // Design:
  // - Pill shape
  // - Pastel background matching category
  // - Icon + text
  // - Selected state: darker background + border
  // - Unselected: light background, no border
}
```

### 4.5 Empty States

#### Cute Empty State
```dart
class CuteEmptyState extends StatelessWidget {
  // Design:
  // - Large illustration (use cute icons)
  // - Soft pastel colors
  // - Friendly message
  // - Cute button with icon

  // Examples:
  // - Empty fridge: 🧊 cute refrigerator icon
  // - No expired items: 🎉 celebration icon
  // - Search not found: 🔍 magnifying glass with sparkle
}
```

---

## 5. SCREEN DESIGNS

### 5.1 Home Screen

#### App Bar Design
```dart
// Gradient background (pink to lavender)
// Height: 120 + status bar
// Shadow: soft gradient fade
// Title: "Tủ Lạnh Của Tôi" with cute icon 🧊💕
// Settings icon: top-right, white
// Search bar: integrated in app bar, rounded pill shape
```

**Layout:**
```
┌─────────────────────────────────────┐
│  🧊 Tủ Lạnh Của Tôi          ⚙️    │ (Gradient Header)
│                                     │
│  🔍 Tìm kiếm thực phẩm...          │ (Search Bar)
│                                     │
│  [Tất cả] [Còn hạn] [Sắp hết] [...] │ (Tabs with badges)
└─────────────────────────────────────┘
```

#### Category Filter
```dart
// Horizontal scrollable chips
// Padding: 16px vertical
// Each chip:
//   - Icon + label
//   - Pill shape
//   - Selected: gradient background
//   - Unselected: white with light border
```

#### Food List
```dart
// Vertical list with spacing
// Each card has subtle entrance animation
// Pull to refresh with custom indicator (spinning flower 🌸)
// Empty state: cute illustration
```

#### FAB (Floating Action Button)
```dart
// Design:
// - Gradient pink to hot pink
// - Size: 56x56
// - Icon: + or ➕
// - Label: "Thêm mới" (extended when scrolling up)
// - Shadow: colored shadow (pink)
// - Position: bottom-right with 16px margin
```

### 5.2 Add/Edit Food Screen

#### Image Picker Section
```dart
// Design:
// - Large rounded square (200x200)
// - Dashed border when empty (pastel pink)
// - Cute camera icon with "Thêm ảnh thực phẩm" 📸
// - When image added: rounded corners, close button top-right
// - Background: light gradient
```

#### Form Layout
```dart
// Sections with headers
// Each section has icon + title
// Spacing between sections: 24px

Sections:
1. Ảnh thực phẩm (Image)
2. Thông tin cơ bản (Basic Info)
   - Name
   - Category dropdown (with icons)
   - Storage location
3. Số lượng (Quantity)
   - Number input + unit dropdown (side by side)
4. Ngày tháng (Dates)
   - Purchase date picker (with calendar icon)
   - Expiry date picker
5. Mã vạch (Optional)
   - Scan button with camera icon
6. Ghi chú (Optional)
   - Multi-line text field
```

#### Action Buttons
```dart
// Bottom bar (fixed)
// Background: white with top shadow
// Buttons:
//   - Cancel: outlined button (left)
//   - Save: gradient button (right)
```

### 5.3 Food Detail Screen

#### Hero Image
```dart
// Full-width image at top
// Height: 250px
// Gradient overlay at bottom
// Back button: top-left (white with shadow)
// Edit button: top-right (white with shadow)
```

#### Status Card
```dart
// Large status badge (centered)
// Background: gradient matching status
// Icon + title + days remaining
// Rounded: 24px
// Shadow: soft
```

#### Info Cards
```dart
// Grid layout (2 columns)
// Each card shows:
//   - Icon (pastel colored)
//   - Label (small text)
//   - Value (bold text)
// Cards: category, location, quantity, purchase date, etc.
```

#### Actions
```dart
// Bottom buttons:
//   - Delete (red outlined)
//   - Edit (gradient filled)
```

---

## 6. ICONS & ILLUSTRATIONS

### Icon Style
```dart
// Use rounded, outlined icons
// Icon pack: Material Icons Rounded
// Custom icons: cute, hand-drawn style
```

### Category Icons (Enhanced)
```dart
categories = {
  'vegetables': '🥬',  // with eco icon
  'fruits': '🍎',      // with apple icon
  'meat': '🥩',        // with steak icon
  'seafood': '🐟',     // with fish icon
  'dairy': '🥛',       // with milk icon
  'beverages': '🥤',   // with drink icon
  'frozen': '🧊',      // with snowflake icon
  'bakery': '🥖',      // with bread icon
  'condiments': '🧂',  // with salt icon
  'others': '📦',      // with box icon
}
```

### Decorative Elements
```dart
// Sparkles: ✨
// Hearts: 💕
// Stars: ⭐
// Flowers: 🌸
// Ribbon: 🎀
```

---

## 7. ANIMATIONS

### Micro-interactions
```dart
// 1. Button Press
// - Scale down to 0.95
// - Duration: 100ms
// - Curve: easeOut

// 2. Card Tap
// - Scale to 0.98
// - Duration: 80ms

// 3. List Item Entry
// - Fade in + slide from bottom
// - Duration: 300ms
// - Stagger: 50ms between items

// 4. Badge Pulse
// - For expiring items
// - Scale: 1.0 to 1.1
// - Duration: 1000ms
// - Repeat: infinite

// 5. Success Feedback
// - Checkmark with scale animation
// - Confetti particles
// - Duration: 500ms
```

### Page Transitions
```dart
// Slide from right with fade
// Duration: 300ms
// Curve: easeOutCubic
```

### Loading States
```dart
// Custom loading indicator
// Spinning flower or heart
// Colors: gradient pink to lavender
```

---

## 8. STICKER/BADGE SYSTEM

### Achievement Badges
```dart
class AchievementBadge {
  // User earns badges for:
  // 1. First food added: "🎉 Người mới"
  // 2. Zero expired items for 7 days: "⭐ Chủ nhà xuất sắc"
  // 3. 10+ items tracked: "💪 Người quản lý chuyên nghiệp"
  // 4. Scan 5 barcodes: "🔍 Thám tử mã vạch"

  // Badge design:
  // - Circular with gradient background
  // - Large emoji/icon
  // - Text below
  // - Shimmer effect when earned
}
```

### Food Status Stickers
```dart
// Overlay on food card images:
// - "Mới" (New): 🎉 green sticker
// - "Ưu tiên ăn": ⚡ orange sticker
// - "Hết hạn": ⚠️ red sticker
// - "Yêu thích": ❤️ pink sticker (user can mark)
```

### Stats Widgets
```dart
// Dashboard cards showing:
// - Total items: 📊
// - Items expiring this week: ⏰
// - Money saved: 💰
// - Waste prevented: ♻️

// Design: rounded cards with gradient backgrounds
```

---

## 9. FLUTTER IMPLEMENTATION NOTES

### Package Requirements
```yaml
dependencies:
  google_fonts: ^6.1.0           # Already included
  flutter_animate: ^4.5.0        # For smooth animations
  shimmer: ^3.0.0                # For loading states
  confetti: ^0.7.0               # For celebrations
  flutter_svg: ^2.0.9            # For custom icons
  lottie: ^3.0.0                 # For animated illustrations
```

### Theme Configuration
```dart
// In lib/utils/constants.dart - Replace AppTheme class
class CuteTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFFFB6C1),
        secondary: Color(0xFFE6E6FA),
        tertiary: Color(0xFFB4E7CE),
        surface: Color(0xFFFFFBF5),
        background: Color(0xFFFFFFFF),
        error: Color(0xFFFF9999),
      ),

      // Typography
      textTheme: TextTheme(
        displayLarge: AppTypography.display,
        headlineLarge: AppTypography.h1,
        headlineMedium: AppTypography.h2,
        titleLarge: AppTypography.h3,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.button,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.h2.copyWith(color: Colors.white),
      ),

      // Card
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.08),
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xFFFFB6C1),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),

      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 8,
        backgroundColor: Color(0xFFFFB6C1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
      ),
    );
  }
}
```

### Widget Architecture
```dart
// Create new widget library:
// lib/widgets/cute/
//   - cute_button.dart
//   - cute_text_field.dart
//   - cute_card.dart
//   - cute_badge.dart
//   - cute_chip.dart
//   - cute_empty_state.dart
//   - cute_loading.dart
//   - cute_dialog.dart
```

### Animation Implementation
```dart
// Use flutter_animate package
import 'package:flutter_animate/flutter_animate.dart';

// Example: Card entry animation
Widget build(BuildContext context) {
  return FoodCard(...)
    .animate()
    .fadeIn(duration: 300.ms)
    .slideY(begin: 0.3, end: 0, curve: Curves.easeOut);
}
```

---

## 10. ACCESSIBILITY CONSIDERATIONS

### Color Contrast
- All text must meet WCAG AA standards (4.5:1 for body, 3:1 for large text)
- Status colors have sufficient contrast with backgrounds
- Don't rely solely on color for status indication (use icons too)

### Touch Targets
- Minimum: 44x44 dp for all interactive elements
- Spacing between buttons: 8dp minimum

### Text Sizing
- Support system font scaling
- Test at 200% text size
- Ensure all UI remains usable

### Screen Reader Support
- Semantic labels for all icons
- Descriptive hints for actions
- Announce status changes

---

## 11. IMPLEMENTATION PRIORITY

### Phase 1: Core Components (Week 1)
1. Update color palette in constants.dart
2. Implement typography system
3. Create cute button components
4. Redesign text fields

### Phase 2: Card & Badges (Week 2)
1. Redesign food card
2. Implement new badge system
3. Create category chips
4. Add stickers

### Phase 3: Screens (Week 3)
1. Redesign home screen
2. Update add/edit screen
3. Enhance detail screen
4. Implement empty states

### Phase 4: Animations & Polish (Week 4)
1. Add micro-interactions
2. Implement page transitions
3. Create loading states
4. Add achievement system

---

## 12. ASSETS TO CREATE

### Images/Illustrations
- Empty state illustrations (5 variants)
- Achievement badge backgrounds (4 designs)
- Category icons (custom, if needed)
- Splash screen illustration

### Animations (Lottie)
- Loading spinner (flower/heart)
- Success celebration (confetti)
- Empty fridge animation
- Pull to refresh indicator

### Export Guidelines
- SVG for vector graphics
- PNG at 1x, 2x, 3x for raster images
- Lottie JSON for animations
- Optimize file sizes

---

## RESOURCES & REFERENCES

### Inspiration
- [Dribbble - Food App Designs](https://dribbble.com/tags/food-app)
- [Behance - Cute UI Designs](https://www.behance.net/search/projects?search=cute+app)
- Pinterest: "Pastel app design", "Feminine UI"

### Icon Sources
- [Material Symbols](https://fonts.google.com/icons)
- [Flaticon - Cute Food Icons](https://www.flaticon.com)
- [Lottie Files](https://lottiefiles.com)

### Color Tools
- [Coolors.co](https://coolors.co) - Palette generator
- [Color Hunt](https://colorhunt.co) - Pastel palettes
- [Adobe Color](https://color.adobe.com) - Accessibility checker

---

**Design Signature:**
This design system prioritizes:
✨ Visual delight & playfulness
💕 Feminine aesthetics without stereotypes
🎯 User-friendly interactions
📱 Mobile-first approach
♿ Inclusive & accessible design
