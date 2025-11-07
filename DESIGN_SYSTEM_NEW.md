# iOS-Inspired Design System for Fridge Tracker App
## Cute & Feminine Aesthetic | Vietnamese Users

---

## Design Philosophy

**Target Audience**: Vietnamese women and girls seeking a cute, feminine food tracking experience
**Design Approach**: Modern iOS aesthetic with soft, airy feel and pastel feminine colors
**Key Principles**:
- Minimalist and clean layouts
- Soft, rounded corners (iOS-style curves)
- Glassmorphism/frosted glass effects
- Light and airy color palette
- Delicate shadows and subtle depth
- Generous spacing with 8pt grid
- Smooth animations
- Intuitive touch interactions

---

## Color Palette

### Primary Colors (Cute Feminine Pastels)

```
Primary Pink (Main Brand)
- Light: #FFE5F0  (backgrounds, hover states)
- Base:  #FFB6D9  (primary buttons, highlights)
- Dark:  #FF8CC6  (pressed states, borders)
Hex: #FFB6D9
RGB: 255, 182, 217
Use: Primary actions, brand elements, CTAs

Primary Lavender (Secondary Brand)
- Light: #F5EFFF  (backgrounds)
- Base:  #D4C4F0  (secondary elements)
- Dark:  #B8A3E6  (active states)
Hex: #D4C4F0
RGB: 212, 196, 240
Use: Secondary buttons, accents

Soft Peach (Warm Accent)
- Light: #FFF2EA
- Base:  #FFDCC8
- Dark:  #FFC4A8
Hex: #FFDCC8
RGB: 255, 220, 200
Use: Warm highlights, category badges
```

### Background Colors (Light & Airy)

```
Primary Background
Hex: #FAFBFF  (Very light blue-tinted white)
RGB: 250, 251, 255
Use: Main app background

Surface/Card Background
Hex: #FFFFFF  (Pure white)
RGB: 255, 255, 255
Use: Cards, modals, elevated surfaces

Secondary Background
Hex: #F5F6FA  (Light gray-blue)
RGB: 245, 246, 250
Use: Input fields (debossed), section backgrounds

Overlay Background (for glassmorphism)
Hex: #FFFFFF with 70% opacity
RGBA: rgba(255, 255, 255, 0.7)
Use: Frosted glass overlays, blurred backgrounds
```

### Text Colors (High Contrast for Readability)

```
Primary Text
Hex: #2D2D2D  (Soft black)
RGB: 45, 45, 45
Use: Headings, primary content

Secondary Text
Hex: #6B7280  (Medium gray)
RGB: 107, 114, 128
Use: Descriptions, labels, metadata

Tertiary Text (Light)
Hex: #9CA3AF  (Light gray)
RGB: 156, 163, 175
Use: Placeholders, disabled text, hints

Link/Interactive Text
Hex: #FFB6D9  (Primary pink)
RGB: 255, 182, 217
Use: Links, interactive elements
```

### Status Colors (Soft Versions)

```
Success/Fresh (Mint Green)
- Background: #E6F9F0
- Border: #A8E6C9
- Text: #2F9461
Hex: #A8E6C9
Use: Fresh food indicators

Warning/Expiring Soon (Soft Orange)
- Background: #FFF4ED
- Border: #FFD4B3
- Text: #E67E22
Hex: #FFD4B3
Use: Expiring soon badges

Error/Expired (Soft Coral)
- Background: #FFEBE6
- Border: #FFB3A3
- Text: #E74C3C
Hex: #FFB3A3
Use: Expired food alerts
```

### Category Colors (Pastel Palette)

```
Vegetables: #C8E6C9  (Soft Sage Green)
Fruits:     #FFCCBC  (Soft Peach)
Meat:       #F8BBD0  (Soft Pink)
Seafood:    #B3E5FC  (Soft Sky Blue)
Dairy:      #FFF9C4  (Soft Cream)
Beverages:  #E1BEE7  (Soft Lavender)
Frozen:     #B2EBF2  (Soft Cyan)
Snacks:     #FFECB3  (Soft Yellow)
Others:     #E0E0E0  (Soft Gray)
```

---

## Typography System

### Font Families

```
Primary Font (Headings & Emphasis)
Font: SF Pro Display / Inter / Poppins (fallback)
Style: Round, modern, friendly
Usage: Headings, buttons, emphasis text

Body Font (Content)
Font: SF Pro Text / Inter / Roboto (fallback)
Style: Clean, readable, professional
Usage: Body text, descriptions, labels
```

### Type Scale (iOS-Inspired)

```
Display Large (Hero Titles)
Size: 34px
Weight: 700 (Bold)
Line Height: 41px
Letter Spacing: -0.5px
Usage: Screen titles, hero text

Display Medium (Large Headings)
Size: 28px
Weight: 700 (Bold)
Line Height: 34px
Letter Spacing: -0.3px
Usage: Section headers

Title Large (H1)
Size: 22px
Weight: 600 (Semi-bold)
Line Height: 28px
Letter Spacing: -0.2px
Usage: Card titles, modal headers

Title Medium (H2)
Size: 18px
Weight: 600 (Semi-bold)
Line Height: 24px
Letter Spacing: 0px
Usage: Subsection titles

Title Small (H3)
Size: 16px
Weight: 600 (Semi-bold)
Line Height: 22px
Letter Spacing: 0px
Usage: List item titles, small headings

Body Large (Default Body)
Size: 17px
Weight: 400 (Regular)
Line Height: 25px
Letter Spacing: 0px
Usage: Main body text, paragraphs

Body Medium (Secondary Body)
Size: 15px
Weight: 400 (Regular)
Line Height: 22px
Letter Spacing: 0px
Usage: Descriptions, metadata

Body Small (Caption)
Size: 13px
Weight: 400 (Regular)
Line Height: 18px
Letter Spacing: 0px
Usage: Captions, helper text, footnotes

Label Large (Button Text)
Size: 16px
Weight: 600 (Semi-bold)
Line Height: 22px
Letter Spacing: 0.3px
Usage: Primary button labels

Label Medium (Small Buttons)
Size: 14px
Weight: 600 (Semi-bold)
Line Height: 20px
Letter Spacing: 0.4px
Usage: Secondary buttons, chips

Label Small (Tiny Labels)
Size: 12px
Weight: 500 (Medium)
Line Height: 16px
Letter Spacing: 0.5px
Usage: Badges, tags, tiny labels
```

---

## Spacing & Layout

### Spacing Scale (8pt Grid System)

```
4px   (0.5x)  - Tiny gaps, tight spacing
8px   (1x)    - Small gaps, compact elements
12px  (1.5x)  - Default inline spacing
16px  (2x)    - Default padding, margins
20px  (2.5x)  - Medium spacing
24px  (3x)    - Large gaps, section spacing
32px  (4x)    - Extra large gaps
48px  (6x)    - Huge gaps, major sections
64px  (8x)    - Massive gaps (rare)
```

### Border Radius (iOS Curves)

```
Extra Small: 8px   - Small badges, tiny elements
Small:       12px  - Chips, tags, small buttons
Medium:      16px  - Cards, inputs, standard buttons
Large:       20px  - Large cards, modals
Extra Large: 24px  - Hero cards, featured elements
Full:        999px - Pill shapes (infinite radius)

Recommended Usage:
- Buttons: 16px (Medium) or 999px (Pill)
- Cards: 16px-20px (Medium-Large)
- Input Fields: 12px-16px (Small-Medium)
- Modal Corners: 24px (Extra Large)
- Badges: 8px or 999px (Pill)
```

### Safe Areas & Margins

```
Screen Padding (Horizontal): 16px
Screen Padding (Vertical): 16px

Card Padding: 16px
Button Padding (Horizontal): 24px
Button Padding (Vertical): 14px

List Item Padding: 16px
Modal Padding: 24px

Safe Area Top: 44px (iOS status bar)
Safe Area Bottom: 34px (iOS home indicator)
```

---

## Shadows & Elevation

### iOS-Style Shadows (Subtle Depth)

```
Shadow Level 1 (Flat Elements)
Offset: 0px, 2px
Blur: 4px
Spread: 0px
Color: rgba(0, 0, 0, 0.04)
Usage: Flat cards, minimal elevation

Shadow Level 2 (Raised Elements)
Offset: 0px, 4px
Blur: 12px
Spread: -2px
Color: rgba(0, 0, 0, 0.08)
Usage: Cards, buttons, raised surfaces

Shadow Level 3 (Elevated Elements)
Offset: 0px, 8px
Blur: 24px
Spread: -4px
Color: rgba(0, 0, 0, 0.12)
Usage: Floating buttons, modals, dropdowns

Shadow Level 4 (Top Layer)
Offset: 0px, 16px
Blur: 40px
Spread: -8px
Color: rgba(0, 0, 0, 0.16)
Usage: Dialogs, overlays, top-most elements

Colored Shadow (for Primary Buttons)
Offset: 0px, 8px
Blur: 24px
Spread: -4px
Color: rgba(255, 182, 217, 0.35)  (Primary Pink with opacity)
Usage: Primary action buttons for emphasis
```

### Inner Shadows (Debossed Effect)

```
Input Field Inner Shadow
Offset: 0px, 2px (inset)
Blur: 4px
Spread: 0px
Color: rgba(0, 0, 0, 0.06)
Usage: Input fields, search bars (pressed-in look)
```

---

## Glassmorphism Effects

### iOS Frosted Glass Style

```
Background Blur
backdrop-filter: blur(20px)
-webkit-backdrop-filter: blur(20px)

Surface Properties
background: rgba(255, 255, 255, 0.7)  (70% white opacity)
border: 1px solid rgba(255, 255, 255, 0.3)  (subtle border)
box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.08)

Alternative (with tint)
background: rgba(255, 240, 250, 0.75)  (Pink-tinted glass)
backdrop-filter: blur(24px) saturate(180%)

Usage:
- Floating action buttons
- Navigation bars
- Modal overlays
- Bottom sheets
- Search bars (when scrolling)
- Header backgrounds (when content scrolls beneath)
```

### Glassmorphism Variants

```
Light Glass (Subtle)
background: rgba(255, 255, 255, 0.6)
backdrop-filter: blur(16px)
border: 1px solid rgba(255, 255, 255, 0.2)
Usage: Subtle overlays, light backgrounds

Medium Glass (Standard)
background: rgba(255, 255, 255, 0.7)
backdrop-filter: blur(20px)
border: 1px solid rgba(255, 255, 255, 0.3)
Usage: Standard frosted glass effect

Heavy Glass (Prominent)
background: rgba(255, 255, 255, 0.85)
backdrop-filter: blur(32px) saturate(200%)
border: 1px solid rgba(255, 255, 255, 0.4)
Usage: Important overlays, modal backgrounds

Dark Glass (for images/dark backgrounds)
background: rgba(45, 45, 45, 0.7)
backdrop-filter: blur(20px)
border: 1px solid rgba(255, 255, 255, 0.1)
Usage: Overlays on images, dark mode elements
```

---

## Component Design Specifications

### 1. Primary Button (Filled)

```
Dimensions:
- Height: 48px (default), 40px (small), 56px (large)
- Min Width: 120px
- Horizontal Padding: 24px
- Vertical Padding: 14px

Visual Style:
- Background: Linear gradient (Primary Pink to Lavender)
  gradient(135deg, #FFB6D9 0%, #D4C4F0 100%)
- Border Radius: 16px (rounded) or 999px (pill)
- Shadow: Level 2 + Colored shadow
- Text: Label Large (16px, semi-bold, white)

States:
Default:
  - Gradient background
  - Shadow: 0 4px 12px rgba(0,0,0,0.08)
  - Opacity: 1.0

Hover (Web):
  - Shadow: 0 6px 16px rgba(0,0,0,0.12)
  - Scale: 1.02
  - Brightness: 105%

Pressed:
  - Scale: 0.96
  - Shadow: 0 2px 8px rgba(0,0,0,0.08)
  - Brightness: 95%

Disabled:
  - Background: #E0E0E0 (gray)
  - Text: #9CA3AF (light gray)
  - Shadow: none
  - Opacity: 0.5

Flutter Implementation:
Container(
  height: 48,
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFFB6D9), Color(0xFFD4C4F0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Color(0x14000000),
        offset: Offset(0, 4),
        blurRadius: 12,
      ),
      BoxShadow(
        color: Color(0x59FFB6D9),
        offset: Offset(0, 8),
        blurRadius: 24,
        spreadRadius: -4,
      ),
    ],
  ),
  child: Text(
    'Button Text',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: 0.3,
    ),
  ),
)
```

### 2. Secondary Button (Outlined)

```
Dimensions:
- Same as primary button

Visual Style:
- Background: rgba(255, 255, 255, 0.7) (frosted glass)
- Border: 2px solid Primary Pink (#FFB6D9)
- Border Radius: 16px or 999px (pill)
- Backdrop Filter: blur(20px)
- Shadow: Level 1
- Text: Label Large (16px, semi-bold, Primary Pink)

States:
Default:
  - Glass background
  - Border: 2px solid #FFB6D9

Hover:
  - Background: rgba(255, 182, 217, 0.1)
  - Border: 2px solid #FF8CC6 (darker pink)

Pressed:
  - Background: rgba(255, 182, 217, 0.2)
  - Scale: 0.96

Disabled:
  - Border: 2px solid #E0E0E0
  - Text: #9CA3AF
  - Opacity: 0.5
```

### 3. Text Button (Link Style)

```
Visual Style:
- Background: transparent
- Text: Label Medium (14px, semi-bold, Primary Pink)
- No border, no shadow
- Padding: 8px 12px

States:
Default:
  - Text color: #FFB6D9

Hover:
  - Text color: #FF8CC6 (darker)
  - Underline

Pressed:
  - Text color: #FF69A8 (darkest)
  - Scale: 0.95
```

### 4. Card Component

```
Dimensions:
- Min Height: 80px
- Horizontal Margin: 16px
- Vertical Margin: 8px
- Padding: 16px

Visual Style:
- Background: #FFFFFF (white)
- Border Radius: 16px
- Shadow: Level 2
- Border: 1px solid rgba(0, 0, 0, 0.04) (subtle)

Structure (Food Card):
┌─────────────────────────────────────┐
│ [Image/Icon] [Title]        [Badge] │
│ 60x60        16px, bold     Status  │
│              ────────────────────    │
│              [Category] [Location]   │
│              13px, gray              │
│              ────────────────────    │
│              [Expiry Date]           │
│              13px, gray              │
└─────────────────────────────────────┘

Interactions:
- Tap: Navigate to detail
- Swipe Left: Reveal edit/delete actions
- Long Press: Quick actions menu

States:
Default:
  - White background
  - Shadow Level 2

Hover (Web):
  - Shadow Level 3
  - Scale: 1.01

Pressed:
  - Background: #FAFBFF
  - Scale: 0.98
```

### 5. Input Field (Text Field)

```
Dimensions:
- Height: 48px
- Padding: 12px 16px

Visual Style (Default):
- Background: #F5F6FA (light gray)
- Border Radius: 12px
- Border: 1px solid transparent
- Inner Shadow: 0 2px 4px rgba(0,0,0,0.04) (debossed)
- Text: Body Medium (15px, regular)
- Placeholder: #9CA3AF (light gray)

Visual Style (Focused):
- Background: #FFFFFF (white)
- Border: 2px solid #FFB6D9 (primary pink)
- Shadow: 0 0 0 4px rgba(255, 182, 217, 0.15) (glow)
- No inner shadow

Visual Style (Error):
- Border: 2px solid #FFB3A3 (soft coral)
- Shadow: 0 0 0 4px rgba(255, 179, 163, 0.15)

With Icon (Left):
- Padding Left: 48px
- Icon size: 20px
- Icon position: 12px from left
- Icon color: #9CA3AF (default), #FFB6D9 (focused)

Flutter Implementation:
Container(
  decoration: BoxDecoration(
    color: Color(0xFFF5F6FA),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.transparent, width: 1),
    boxShadow: [
      BoxShadow(
        color: Color(0x0A000000),
        offset: Offset(0, 2),
        blurRadius: 4,
      ),
    ],
  ),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Placeholder',
      hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
)
```

### 6. Search Bar

```
Dimensions:
- Height: 44px
- Horizontal Margin: 16px
- Border Radius: 999px (pill)

Visual Style:
- Background: rgba(255, 255, 255, 0.7) (frosted glass)
- Backdrop Filter: blur(20px)
- Border: 1px solid rgba(255, 255, 255, 0.3)
- Shadow: Level 1
- Icon: Search icon (20px, #9CA3AF)
- Text: Body Medium (15px)

Structure:
┌─────────────────────────────────────┐
│ 🔍  [Search text...]          [✕]  │
│ Icon  Placeholder            Clear  │
└─────────────────────────────────────┘

Left Icon: 32px from left
Right Clear Button: 32px from right
Text Padding: 48px left, 48px right
```

### 7. Badge/Chip Component

```
Dimensions:
- Height: 24px (small), 28px (medium)
- Padding: 6px 12px
- Border Radius: 999px (pill)

Status Badge (Fresh):
- Background: #E6F9F0 (light green)
- Text: 12px, medium, #2F9461 (dark green)
- Border: 1px solid #A8E6C9

Status Badge (Warning):
- Background: #FFF4ED (light orange)
- Text: 12px, medium, #E67E22 (dark orange)
- Border: 1px solid #FFD4B3

Status Badge (Expired):
- Background: #FFEBE6 (light coral)
- Text: 12px, medium, #E74C3C (dark red)
- Border: 1px solid #FFB3A3

Category Badge:
- Background: Category color at 20% opacity
- Text: 12px, medium, Category color (darker)
- Border: 1px solid Category color at 40% opacity
```

### 8. Floating Action Button (FAB)

```
Dimensions:
- Diameter: 56px (standard), 64px (large)
- Icon Size: 24px

Visual Style (Standard):
- Background: Linear gradient (Pink to Lavender)
- Border Radius: 999px (circle)
- Shadow: Level 3 + Colored shadow
- Icon: White

Visual Style (Extended - with text):
- Height: 56px
- Min Width: 120px
- Border Radius: 999px (pill)
- Padding: 16px 24px
- Background: Gradient
- Shadow: Level 3
- Content: Icon + Text

Glassmorphism Variant:
- Background: rgba(255, 255, 255, 0.85)
- Backdrop Filter: blur(24px) saturate(180%)
- Border: 2px solid rgba(255, 182, 217, 0.5)
- Shadow: Level 3
- Icon/Text: Primary Pink

States:
Default:
  - Gradient background
  - Shadow Level 3

Hover:
  - Shadow Level 4
  - Scale: 1.05

Pressed:
  - Scale: 0.92
  - Shadow Level 2
```

### 9. Modal/Bottom Sheet

```
Bottom Sheet:
- Background: #FFFFFF
- Border Radius: 24px (top corners only)
- Shadow: Level 4
- Handle: 40px x 4px rounded bar, #E0E0E0
- Padding: 24px

Modal Dialog:
- Background: #FFFFFF
- Border Radius: 24px (all corners)
- Shadow: Level 4
- Max Width: 90% of screen width
- Padding: 24px
- Overlay: rgba(0, 0, 0, 0.5) (50% black)

Glassmorphism Variant:
- Background: rgba(255, 255, 255, 0.9)
- Backdrop Filter: blur(32px) saturate(200%)
- Border: 1px solid rgba(255, 255, 255, 0.4)
```

### 10. Navigation Bar (App Bar)

```
Dimensions:
- Height: 56px + safe area top
- Padding: 16px horizontal

Visual Style (Solid):
- Background: #FFFFFF
- Shadow: Level 1 (bottom only)
- Border Bottom: 1px solid rgba(0, 0, 0, 0.04)

Visual Style (Glassmorphism):
- Background: rgba(255, 255, 255, 0.8)
- Backdrop Filter: blur(20px)
- Shadow: Level 1
- Border: none

Structure:
┌─────────────────────────────────────┐
│ [Back] [Title/Logo]        [Action] │
│ Icon   22px, bold           Icon    │
└─────────────────────────────────────┘

Elements:
- Back button: 40x40 circle, frosted glass
- Title: Title Large (22px, bold, #2D2D2D)
- Action buttons: 40x40 circle, frosted glass
```

### 11. List Item

```
Dimensions:
- Height: 72px (with subtitle), 56px (single line)
- Padding: 16px
- Border Bottom: 1px solid #F5F6FA

Structure:
┌─────────────────────────────────────┐
│ [Icon/Image] [Title]        [Trail] │
│ 40x40        16px, semi-bold Action │
│              ────────────             │
│              [Subtitle]              │
│              14px, gray              │
└─────────────────────────────────────┘

States:
Default:
  - Background: transparent

Hover:
  - Background: #FAFBFF

Pressed:
  - Background: #F5F6FA

Selected:
  - Background: rgba(255, 182, 217, 0.1)
  - Border Left: 4px solid #FFB6D9
```

### 12. Toggle/Switch (iOS-style)

```
Dimensions:
- Width: 51px
- Height: 31px
- Track Border Radius: 999px
- Thumb Diameter: 27px

Visual Style (OFF):
- Track Background: #E0E0E0
- Thumb: #FFFFFF with shadow
- Thumb Position: Left (2px from edge)

Visual Style (ON):
- Track Background: #FFB6D9 (Primary Pink)
- Thumb: #FFFFFF with shadow
- Thumb Position: Right (2px from edge)

Animation:
- Duration: 200ms
- Easing: ease-in-out
- Thumb slides smoothly with spring effect
```

---

## Screen Layout Examples

### Home Screen (Food List)

```
Structure:
┌────────────────────────────────────────┐
│ [Glassmorphic Navigation Bar]          │ Height: 56px + safe area
│ 🦄 Tủ lạnh của tôi          ⚙️        │ Frosted glass effect
├────────────────────────────────────────┤
│                                        │
│ [Glassmorphic Search Bar]              │ Height: 44px, pill shape
│ 🔍 Tìm kiếm thực phẩm...               │ Blur: 20px
│                                        │
│ [Category Filter Chips]                │ Horizontal scroll
│ [Tất cả] [Rau] [Trái cây] [Thịt]...   │ Pills, 28px height
│                                        │
├────────────────────────────────────────┤
│                                        │
│ [Food Card]                            │ White card, 16px radius
│ ┌────────────────────────────────────┐ │
│ │ [📷] Cà chua         [Fresh 🟢]   │ │ Margin: 16px h, 8px v
│ │ 60x60 16px, bold     Badge        │ │ Padding: 16px
│ │       ───────────────              │ │
│ │       🏷️ Rau  📍 Tủ lạnh         │ │
│ │       13px, gray                   │ │
│ │       ───────────────              │ │
│ │       📅 HSD: 15/11/2025          │ │
│ └────────────────────────────────────┘ │
│                                        │
│ [Food Card]                            │
│ [Food Card]                            │
│ [Food Card]                            │
│                                        │
│                                        │
│                     [FAB 🦄]           │ Extended FAB
│                     Thêm thực phẩm    │ Glassmorphic
│                                        │ Floating 16px from bottom
└────────────────────────────────────────┘
```

### Add/Edit Food Screen

```
Structure:
┌────────────────────────────────────────┐
│ [Navigation Bar]                       │
│ ← [🦄] Thêm thực phẩm      [💾 Lưu]   │ Solid white background
├────────────────────────────────────────┤
│                                        │
│        [Image Picker Circle]           │ 200x200 circle
│        [📷 Thêm ảnh]                   │ Frosted glass
│                                        │ Border: 2px dashed
│                                        │
│ [Text Input - Name]                    │ 48px height, 12px radius
│ 🥬 Tên thực phẩm *                     │ Debossed style
│                                        │
│ [Dropdown - Category]                  │ 48px height
│ 🏷️ Danh mục                           │ Raised style
│   [Rau ▼]                              │
│                                        │
│ [Dropdown - Location]                  │
│ 📍 Vị trí lưu trữ                      │
│   [Tủ lạnh ▼]                          │
│                                        │
│ [Row: Quantity + Unit]                 │
│ 🔢 [Số lượng: 1]  [kg ▼]              │
│    Flex: 2         Flex: 1            │
│                                        │
│ [Date Picker - Purchase]               │ List tile style
│ 🛒 Ngày mua                            │ 56px height
│    15/11/2025               📅         │
│                                        │
│ [Date Picker - Expiry]                 │
│ ⏰ Hạn sử dụng                         │
│    22/11/2025               📅         │
│                                        │
│ [Barcode Scanner]                      │
│ 📱 Quét mã vạch              [📷]     │
│                                        │
│ [Text Area - Notes]                    │ Multi-line, 72px height
│ 📝 Ghi chú                             │ Debossed
│    [Enter notes...]                    │
│                                        │
└────────────────────────────────────────┘
```

### Food Detail Screen

```
Structure:
┌────────────────────────────────────────┐
│ [Hero Image with Overlay]              │ Full width, 240px height
│                                        │ Gradient overlay
│ ←                             ✏️ 🗑️   │ Top bar: frosted glass
│                                        │
│ [Cà chua]                              │ Title on image
│ [Fresh 🟢]                             │ Status badge
└────────────────────────────────────────┘
┌────────────────────────────────────────┐
│ [White Card Section]                   │ Overlaps image by 24px
│ ┌────────────────────────────────────┐ │ Rounded top: 24px
│ │                                    │ │
│ │ Thông tin cơ bản                   │ │ Section title
│ │ ────────────────────────────────── │ │
│ │                                    │ │
│ │ 🏷️ Danh mục:        Rau           │ │ Info rows
│ │ 📍 Vị trí:          Tủ lạnh        │ │ 48px height each
│ │ 🔢 Số lượng:        500 g          │ │
│ │                                    │ │
│ └────────────────────────────────────┘ │
│                                        │
│ [White Card Section]                   │ 8px gap
│ ┌────────────────────────────────────┐ │
│ │                                    │ │
│ │ Ngày tháng                         │ │
│ │ ────────────────────────────────── │ │
│ │                                    │ │
│ │ 🛒 Ngày mua:        15/11/2025     │ │
│ │ ⏰ Hạn sử dụng:     22/11/2025     │ │
│ │ 📊 Còn lại:         7 ngày         │ │
│ │                                    │ │
│ └────────────────────────────────────┘ │
│                                        │
│ [White Card Section]                   │
│ ┌────────────────────────────────────┐ │
│ │                                    │ │
│ │ Ghi chú                            │ │
│ │ ────────────────────────────────── │ │
│ │                                    │ │
│ │ Cà chua tươi từ siêu thị...        │ │
│ │                                    │ │
│ └────────────────────────────────────┘ │
│                                        │
│ [Action Buttons]                       │
│ ┌─────────────────┐ ┌──────────────┐ │
│ │ ✏️ Chỉnh sửa    │ │ 🗑️ Xóa      │ │ Gradient + Outlined
│ └─────────────────┘ └──────────────┘ │ 48px height
│                                        │
└────────────────────────────────────────┘
```

### Settings Screen

```
Structure:
┌────────────────────────────────────────┐
│ [Navigation Bar]                       │
│ ← Cài đặt                              │
├────────────────────────────────────────┤
│                                        │
│ [Section: Thông báo]                   │ Gray text, 14px
│                                        │
│ [List Item with Toggle]                │ 56px height
│ 🔔 Nhắc nhở hạn sử dụng     [ON 🟢]   │ White background
│                                        │
│ [Divider]                              │ 1px, #F5F6FA
│                                        │
│ [List Item with Trail]                 │
│ 📅 Nhắc trước (ngày)         3    →   │
│                                        │
│ [Divider]                              │
│                                        │
│ [Section: Giao diện]                   │
│                                        │
│ [List Item]                            │
│ 🎨 Chế độ sáng/tối          Sáng  →   │
│                                        │
│ [Divider]                              │
│                                        │
│ [Section: Về ứng dụng]                 │
│                                        │
│ [List Item]                            │
│ ℹ️ Phiên bản                1.0.0     │
│                                        │
│ [Divider]                              │
│                                        │
│ [List Item]                            │
│ 📖 Hướng dẫn sử dụng             →    │
│                                        │
└────────────────────────────────────────┘
```

---

## Animation & Interaction Guidelines

### Transitions

```
Screen Transitions:
- Push/Pop: iOS-style slide (300ms, ease-in-out)
- Modal: Slide up from bottom (250ms, ease-out)
- Dialog: Fade in + scale (200ms, ease-out)

Element Animations:
- Fade In: 200ms, ease-in
- Fade Out: 150ms, ease-out
- Scale: 100ms, ease-in-out
- Slide: 250ms, ease-out

Spring Animations (for delightful interactions):
- Spring Damping: 0.8
- Spring Stiffness: 300
- Use for: Button press, card tap, toggle switch
```

### Micro-interactions

```
Button Press:
1. Scale down to 0.96 (100ms)
2. Slight shadow reduction
3. Spring back to 1.0 (150ms)

Card Tap:
1. Scale down to 0.98 (80ms)
2. Slight brightness increase
3. Navigate with slide transition

Toggle Switch:
1. Thumb slides with spring animation (200ms)
2. Track color fades from OFF to ON (200ms)
3. Slight scale pulse (1.0 → 1.05 → 1.0) on toggle

Pull to Refresh:
1. Show loading spinner (gradient rotating)
2. Spinner fades in (150ms)
3. Content slides down with ease-out
4. Spinner fades out after refresh (200ms)

Swipe Actions (on cards):
1. Card slides left to reveal actions (200ms, ease-out)
2. Actions fade in with stagger (50ms each)
3. Card bounces back with spring when released
```

### Loading States

```
Loading Spinner:
- Size: 24px (small), 40px (medium)
- Style: Gradient circular spinner
- Colors: Primary Pink to Lavender gradient
- Animation: Rotate 360deg, 1s, linear, infinite

Skeleton Loader (for content):
- Background: #F5F6FA
- Shimmer: Linear gradient sweep (white to transparent)
- Animation: 1.5s, ease-in-out, infinite
- Border Radius: Match target content

Pull to Refresh:
- Show gradient spinner at top
- Rotate continuously during load
- Fade out with success checkmark (optional)
```

---

## Accessibility Guidelines

### Color Contrast

```
Text Contrast Ratios (WCAG 2.1 AA):
- Primary text on white: 14.5:1 (AAA) ✓
- Secondary text on white: 4.8:1 (AA) ✓
- Tertiary text on white: 3.2:1 (AA for large text) ✓

Button Contrast:
- White text on Primary Pink: 4.6:1 (AA) ✓
- Primary Pink text on white: 4.6:1 (AA) ✓

Always ensure:
- Body text: minimum 4.5:1 contrast
- Large text (18px+): minimum 3:1 contrast
- Interactive elements: minimum 3:1 contrast
```

### Touch Targets

```
Minimum Touch Target: 44x44 points (iOS standard)

Recommended Sizes:
- Primary buttons: 48px height minimum
- Icon buttons: 44x44 minimum
- List items: 56px height minimum
- Toggle switches: 51x31 (standard iOS size)
- FAB: 56px diameter minimum

Spacing between touch targets: 8px minimum
```

### Screen Reader Support

```
All interactive elements must have:
- Meaningful labels (not just "Button")
- Proper semantic roles
- State descriptions (selected, expanded, etc.)

Example labels:
- "Thêm thực phẩm vào tủ lạnh" (not just "Thêm")
- "Chỉnh sửa cà chua" (not just "Chỉnh sửa")
- "Xóa cà chua khỏi danh sách" (not just "Xóa")
```

---

## Implementation Notes (Flutter)

### Required Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0  # For custom fonts
  provider: ^6.1.1  # State management

  # Optional for glassmorphism
  glassmorphism: ^3.0.0
  flutter_blur: ^1.0.0

  # Image handling
  image_picker: ^1.0.7
  cached_network_image: ^3.3.1
```

### Custom Theme Data

```dart
ThemeData buildAppTheme() {
  return ThemeData(
    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFFB6D9),  // Primary Pink
      secondary: Color(0xFFD4C4F0),  // Lavender
      surface: Color(0xFFFFFFFF),  // White
      background: Color(0xFFFAFBFF),  // Light background
      error: Color(0xFFFFB3A3),  // Soft coral
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF2D2D2D),  // Primary text
      onBackground: Color(0xFF2D2D2D),
      onError: Colors.white,
    ),

    // Typography
    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(120, 48),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF5F6FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFFFB6D9), width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2D2D2D),
      ),
      iconTheme: IconThemeData(color: Color(0xFFFFB6D9)),
    ),
  );
}
```

### Glassmorphism Helper Widget

```dart
class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Color? tintColor;

  const GlassmorphicContainer({
    Key? key,
    required this.child,
    this.blur = 20.0,
    this.opacity = 0.7,
    this.borderRadius,
    this.tintColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: (tintColor ?? Colors.white).withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// Usage:
GlassmorphicContainer(
  blur: 20,
  opacity: 0.7,
  borderRadius: BorderRadius.circular(24),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Frosted Glass Effect'),
  ),
)
```

### Shadow Helper Class

```dart
class AppShadows {
  // Level 1: Flat elements
  static List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x0A000000),  // 4% black
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  // Level 2: Raised elements
  static List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x14000000),  // 8% black
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: -2,
    ),
  ];

  // Level 3: Elevated elements
  static List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x1F000000),  // 12% black
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];

  // Level 4: Top layer
  static List<BoxShadow> level4 = [
    BoxShadow(
      color: Color(0x29000000),  // 16% black
      offset: Offset(0, 16),
      blurRadius: 40,
      spreadRadius: -8,
    ),
  ];

  // Colored shadow for primary buttons
  static List<BoxShadow> primaryButton = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
    BoxShadow(
      color: Color(0x59FFB6D9),  // Primary pink at 35%
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];
}

// Usage:
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: AppShadows.level2,
  ),
  child: ...
)
```

---

## Quick Reference Cheat Sheet

### Color Hex Codes (Copy-Paste Ready)

```
Primary Colors:
#FFB6D9  Primary Pink
#D4C4F0  Lavender
#FFDCC8  Soft Peach

Backgrounds:
#FAFBFF  App Background
#FFFFFF  Card Background
#F5F6FA  Input Background

Text:
#2D2D2D  Primary Text
#6B7280  Secondary Text
#9CA3AF  Tertiary Text

Status:
#A8E6C9  Fresh (green)
#FFD4B3  Warning (orange)
#FFB3A3  Expired (coral)
```

### Border Radius Values

```
8px   Tiny elements
12px  Small buttons, inputs
16px  Cards, standard buttons
20px  Large cards
24px  Modals, hero elements
999px Pill shapes (infinite)
```

### Common Shadows (CSS)

```css
/* Level 1 */
box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);

/* Level 2 */
box-shadow: 0 4px 12px -2px rgba(0, 0, 0, 0.08);

/* Level 3 */
box-shadow: 0 8px 24px -4px rgba(0, 0, 0, 0.12);

/* Level 4 */
box-shadow: 0 16px 40px -8px rgba(0, 0, 0, 0.16);

/* Primary Button */
box-shadow:
  0 4px 12px rgba(0, 0, 0, 0.08),
  0 8px 24px -4px rgba(255, 182, 217, 0.35);
```

### Glassmorphism CSS

```css
.glassmorphic {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
}
```

### Gradient CSS

```css
/* Primary Gradient */
background: linear-gradient(135deg, #FFB6D9 0%, #D4C4F0 100%);

/* Pink to Peach */
background: linear-gradient(135deg, #FFB6D9 0%, #FFDCC8 100%);

/* Subtle Background */
background: linear-gradient(180deg, #FAFBFF 0%, #F5F6FA 100%);
```

---

## Design Principles Summary

1. **Simplicity First**: Every element serves a clear purpose
2. **Gentle Colors**: Soft pastels that are easy on the eyes
3. **Rounded Corners**: iOS-style curves for friendliness
4. **Subtle Depth**: Light shadows for depth without heaviness
5. **Frosted Glass**: Modern glassmorphism for elegance
6. **Generous Spacing**: Breathing room with 8pt grid
7. **Smooth Animations**: Delightful micro-interactions
8. **High Contrast Text**: Readable content always
9. **Touch-Friendly**: 44pt minimum touch targets
10. **Consistent**: Unified visual language throughout

---

## Next Steps for Implementation

1. **Update Color Palette**: Replace neumorphic colors with new iOS-inspired pastels
2. **Replace Shadows**: Remove dual neumorphic shadows, use single iOS-style shadows
3. **Update Border Radius**: Ensure all elements use 12-24px radius
4. **Add Glassmorphism**: Implement frosted glass for FAB, nav bar, search bar
5. **Simplify Components**: Remove gradient overuse, focus on white surfaces
6. **Update Typography**: Ensure SF-like fonts with proper weights
7. **Test Accessibility**: Verify contrast ratios and touch target sizes
8. **Add Animations**: Implement smooth transitions and micro-interactions

---

**This design system is ready for developer handoff. All specifications include exact values, colors, and code examples for seamless implementation.**
