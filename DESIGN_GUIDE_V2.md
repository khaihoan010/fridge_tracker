# 🌸 Fridge Tracker - Design System V2
## Feminine, Modern & Delightful

---

## 🎨 Color Palette - Soft Feminine

### Primary Colors
```
Rose Quartz     #FFD6E8  - Main brand color (soft pink)
Lavender Mist   #E8D5F2  - Secondary (light purple)
Mint Cream      #D5F2E3  - Success/Fresh
Peach Blossom   #FFE4D6  - Warning
Coral Blush     #FFD4D4  - Error/Expired
```

### Neutral Colors
```
Snow White      #FAFBFC  - Background
Pearl Gray      #F5F7FA  - Cards
Dove Gray       #E8EAED  - Borders
Silver Cloud    #C4C9D0  - Disabled
Charcoal Soft   #4A5568  - Text primary
Slate Muted     #718096  - Text secondary
```

### Accent Colors
```
Golden Hour     #FFE5B4  - Highlights
Sky Soft        #D6E8FF  - Info
Mint Fresh      #B4F0D7  - Active
```

---

## ✨ Typography - Rounded & Gentle

### Font Family
- **Primary:** Quicksand (Rounded, friendly)
- **Secondary:** Nunito (Soft, readable)
- **Monospace:** JetBrains Mono (for numbers)

### Type Scale
```
Hero Large    32px / 700 / 1.2  - Page titles
Title Large   24px / 600 / 1.3  - Section headers
Title Medium  20px / 600 / 1.4  - Card titles
Body Large    16px / 400 / 1.5  - Body text
Body Medium   14px / 400 / 1.5  - Secondary text
Body Small    12px / 400 / 1.4  - Captions
Label         12px / 600 / 1.2  - Labels, badges
```

---

## 📐 Spacing System - Breathing Room

```
4px   - xs   - Icon padding
8px   - s    - Tight spacing
12px  - m    - Standard spacing
16px  - l    - Card padding
20px  - xl   - Section padding
24px  - 2xl  - Large gaps
32px  - 3xl  - Screen padding
48px  - 4xl  - Hero spacing
```

---

## 🎭 Border Radius - Extra Rounded

```
4px   - xs   - Badges
8px   - s    - Small buttons
12px  - m    - Input fields
16px  - l    - Cards
20px  - xl   - Large cards
24px  - 2xl  - Hero cards
999px - full - Pills, tags
```

---

## 🌟 Shadows - Soft & Subtle

```css
/* Soft Shadow - Cards */
box-shadow: 0 2px 8px rgba(255, 214, 232, 0.15),
            0 1px 3px rgba(0, 0, 0, 0.06);

/* Medium Shadow - Floating elements */
box-shadow: 0 4px 12px rgba(255, 214, 232, 0.20),
            0 2px 6px rgba(0, 0, 0, 0.08);

/* Strong Shadow - Modals */
box-shadow: 0 8px 24px rgba(255, 214, 232, 0.25),
            0 4px 12px rgba(0, 0, 0, 0.10);

/* Glow - Active states */
box-shadow: 0 0 0 4px rgba(255, 214, 232, 0.20);
```

---

## 🎨 Gradients - Dreamy & Soft

```css
/* Primary Gradient */
linear-gradient(135deg, #FFD6E8 0%, #E8D5F2 100%)

/* Success Gradient */
linear-gradient(135deg, #D5F2E3 0%, #B4F0D7 100%)

/* Warning Gradient */
linear-gradient(135deg, #FFE4D6 0%, #FFD6C4 100%)

/* Sunset Gradient */
linear-gradient(135deg, #FFE5B4 0%, #FFD6E8 50%, #E8D5F2 100%)

/* Card Gradient - Subtle */
linear-gradient(180deg, #FAFBFC 0%, #F5F7FA 100%)
```

---

## 🦄 Icons & Emojis

### Use Emojis Consistently
```
🥗 Vegetables
🍎 Fruits
🥩 Meat
🐟 Seafood
🥛 Dairy
🥤 Beverages
❄️  Frozen
🍪 Snacks
📦 Others

🧊 Freezer
🧃 Fridge
🗄️ Pantry
🍽️ Counter

✨ Fresh
⚠️ Expiring Soon
❌ Expired
```

---

## 🎯 Component Patterns

### Card Design
- Extra rounded corners (16-20px)
- Soft shadows
- Gradient backgrounds (optional)
- Padding: 16-20px
- Hover: slight lift + glow

### Buttons
- **Primary:** Gradient + rounded + shadow
- **Secondary:** Outline + rounded
- **Ghost:** Text only + hover glow
- Height: 44-48px (touch-friendly)

### Input Fields
- Rounded (12px)
- Soft border (1px)
- Focus: glow effect
- Placeholder: cute text
- Icons: left-aligned

### Badges
- Pill-shaped (999px radius)
- Gradient or solid
- Small text (12px)
- Padding: 4px 12px

---

## 🌈 Status Colors

### Fresh (3+ days)
```
Background: #D5F2E3
Border: #B4F0D7
Text: #2D6854
Icon: ✨
```

### Expiring Soon (1-3 days)
```
Background: #FFE4D6
Border: #FFD6C4
Text: #8B5A3C
Icon: ⚠️
```

### Expired (0 days)
```
Background: #FFD4D4
Border: #FFC0C0
Text: #8B3A3A
Icon: ❌
```

---

## 🎪 Micro-interactions

### Hover Effects
- Scale: 1.02
- Shadow: increase
- Transition: 200ms ease

### Tap/Click
- Scale: 0.98
- Haptic feedback
- Ripple effect

### Loading
- Shimmer effect
- Soft pulse
- Skeleton screens

---

## 📱 Responsive Breakpoints

```
Mobile:  < 600px
Tablet:  600px - 900px
Desktop: > 900px
```

---

## ✅ Accessibility

- Contrast ratio: 4.5:1 minimum
- Touch targets: 44x44px minimum
- Focus indicators: visible glow
- Screen reader friendly
- Color blind safe

---

## 🎨 Theme Variations

### Light Mode (Default)
- Background: #FAFBFC
- Cards: #FFFFFF
- Text: #4A5568

### Dark Mode (Optional)
- Background: #1A1D23
- Cards: #252A31
- Text: #E8EAED
- Accents: Lighter versions

---

## 🌟 Brand Personality

- **Feminine:** Soft colors, rounded corners, gentle shadows
- **Modern:** Clean layout, minimalist, lots of white space
- **Delightful:** Emojis, micro-interactions, smooth animations
- **Friendly:** Warm colors, approachable typography
- **Trustworthy:** Clear hierarchy, consistent patterns

---

## 📋 Do's and Don'ts

### ✅ Do
- Use soft pastel colors
- Add plenty of white space
- Use emojis for personality
- Round all corners
- Add subtle animations

### ❌ Don't
- Use harsh colors
- Overcrowd the UI
- Use sharp corners
- Ignore touch targets
- Overuse animations

---

**Design Philosophy:**
"Every interaction should feel like a gentle breeze, not a harsh wind."
