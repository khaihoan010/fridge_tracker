# 📊 PHÂN TÍCH TOÀN DIỆN - FRIDGE TRACKER APP

> Phân tích chi tiết về ứng dụng quản lý thực phẩm dành cho phụ nữ

---

## 📖 MỤC LỤC

1. [Tổng Quan Hiện Tại](#1-tổng-quan-hiện-tại)
2. [Yêu Cầu Mới Từ User](#2-yêu-cầu-mới-từ-user)
3. [Nguồn Dữ Liệu](#3-nguồn-dữ-liệu)
4. [Chức Năng Cần Phát Triển](#4-chức-năng-cần-phát-triển)
5. [Kiến Trúc & Database](#5-kiến-trúc--database)
6. [Custom Subagents](#6-custom-subagents)
7. [Roadmap Phát Triển](#7-roadmap-phát-triển)
8. [Technical Implementation](#8-technical-implementation)

---

## 1. TỔNG QUAN HIỆN TẠI

### ✅ Đã Có

**Core Features:**
- ✅ Quản lý thực phẩm (CRUD)
- ✅ Food Database với 95 items (USDA standards)
- ✅ Smart Autocomplete với fuzzy Vietnamese search
- ✅ Auto-calculation ngày hết hạn dựa trên storage location
- ✅ Barcode scanning (Open Food Facts API)
- ✅ Expiry tracking với notification
- ✅ Search & filtering (category, location, status)
- ✅ Image management
- ✅ SQLite local database
- ✅ V2 Design System (feminine, modern)

**Tech Stack:**
- Flutter 3.8.1+
- SQLite (sqflite)
- Provider (state management)
- Open Food Facts API (barcode lookup)

**Food Database Current:**
- 95 food items
- Vietnamese & English names
- Shelf life data (pantry/fridge/freezer)
- Storage tips
- Categories: vegetables, fruits, meats, seafood, dairy

### ❌ Chưa Có

- ❌ **Nutrition information** (calories, protein, vitamins, minerals)
- ❌ **Health analysis** (đánh giá sản phẩm tốt cho sức khỏe)
- ❌ **Vitamin/Mineral tracking**
- ❌ **Dietary recommendations**
- ❌ **Recipe suggestions**
- ❌ **Shopping list with nutrition goals**
- ❌ **Food waste analytics**
- ❌ **Meal planning**

---

## 2. YÊU CẦU MỚI TỪ USER

### 🎯 Mục Tiêu Chính

> "Tạo 1 ứng dụng để giúp **phụ nữ** quản lí các thực phẩm trong tủ lạnh từ rau củ quả, trái cây, thịt, trứng cá,... 1 cách hiệu quả"

### 📋 Yêu Cầu Cụ Thể

#### 2.1 Notification Ngày Hết Hạn
✅ **ĐÃ CÓ** - Thông báo X ngày trước hết hạn

#### 2.2 Phân Tích/Đánh Giá Sản Phẩm
❌ **CẦN THÊM:**
- Đánh giá sản phẩm có tốt cho sức khỏe hay không
- Phân tích dinh dưỡng (calories, protein, fat, carbs)
- Cảnh báo allergens
- Phù hợp cho chế độ ăn nào (vegan, keto, low-carb, etc.)
- Health score (0-100)

#### 2.3 Cung Cấp Thông Tin Vitamin
❌ **CẦN THÊM:**
- Danh sách vitamin trong thực phẩm (A, B, C, D, E, K)
- Minerals (Iron, Calcium, Zinc, etc.)
- Phần trăm RDA (Recommended Daily Allowance)
- Benefits của từng vitamin/mineral
- Visualization (charts, badges)

#### 2.4 Smart Recommendation
✅ **ĐÃ CÓ CƠ BẢN** - Autocomplete theo category
❌ **CẦN NÂNG CAO:**
- Recommend dựa trên nutrition goals
- Suggest alternatives (healthier options)
- "Bạn nên mua gì?" based on current inventory
- "Món gì nên nấu?" based on expiring foods

---

## 3. NGUỒN DỮ LIỆU

### 🌐 API Sources (FREE)

#### 3.1 USDA FoodData Central API ⭐️ **RECOMMEND**
**URL:** https://fdc.nal.usda.gov/api-guide.html

**Ưu điểm:**
- ✅ **MIỄN PHÍ** - API key free, unlimited requests
- ✅ **Chính xác nhất** - Dữ liệu chính phủ Mỹ
- ✅ **400,000+ foods** - Database khổng lồ
- ✅ **Full nutrition data** - Vitamins, minerals, macros
- ✅ **Vietnamese foods** - Có một số món Việt
- ✅ **JSON API** - Dễ integrate

**Data Available:**
```json
{
  "fdcId": 123456,
  "description": "Tomato, raw",
  "foodNutrients": [
    {
      "nutrientName": "Protein",
      "value": 0.9,
      "unitName": "g"
    },
    {
      "nutrientName": "Vitamin C",
      "value": 13.7,
      "unitName": "mg"
    }
  ],
  "foodCategory": "Vegetables",
  "servingSize": 100,
  "servingSizeUnit": "g"
}
```

**Rate Limit:** Unlimited (với API key)

**Cách Dùng:**
```dart
// Search food
GET https://api.nal.usda.gov/fdc/v1/foods/search
  ?query=tomato
  &api_key=YOUR_KEY

// Get food details
GET https://api.nal.usda.gov/fdc/v1/food/{fdcId}
  ?api_key=YOUR_KEY
```

#### 3.2 Open Food Facts API (ĐÃ DÙNG)
**URL:** https://world.openfoodfacts.org/data

**Ưu điểm:**
- ✅ **ĐÃ INTEGRATE** - Dùng cho barcode scanning
- ✅ Miễn phí, open source
- ✅ 2.8 million products
- ✅ Nutrition Score (A-E)
- ✅ Allergens, additives

**Mở rộng:**
```dart
// Get nutrition data từ barcode
GET https://world.openfoodfacts.org/api/v2/product/{barcode}.json

Response:
{
  "product": {
    "nutriments": {
      "energy-kcal": 52,
      "proteins": 2.6,
      "carbohydrates": 3.9,
      "fat": 0.2
    },
    "nutrition_grades": "b", // A-E score
    "allergens": "gluten,milk",
    "vitamins": {...}
  }
}
```

#### 3.3 Nutritionix API (Alternative)
**URL:** https://www.nutritionix.com/business/api

**Free Tier:**
- ✅ 500 requests/day free
- ✅ Natural language search ("1 quả táo")
- ✅ 800,000+ foods
- ❌ Limited free tier

#### 3.4 Edamam Nutrition Analysis API
**URL:** https://developer.edamam.com/edamam-nutrition-api

**Free Tier:**
- ✅ 10,000 requests/month free
- ✅ Recipe analysis
- ✅ Nutrition data
- ❌ Requires signup

### 📊 Local Database Strategy

#### Hybrid Approach (RECOMMENDED)

**1. Static Database (JSON File)**
- Pre-populated với 1000+ Vietnamese foods phổ biến
- Include full nutrition data
- Update định kỳ qua app update
- **Size estimate:** ~2-3MB compressed

**2. Dynamic API Calls**
- Barcode scanning → Open Food Facts API
- User search không tìm thấy → USDA API
- Cache results locally

**3. User-Generated Data**
- User có thể tự thêm nutrition data
- Crowdsource từ community (future)

### 💾 Database Solution

#### Option 1: SQLite + JSON (CURRENT + EXPAND) ⭐️ RECOMMEND

**Pros:**
- ✅ Offline-first
- ✅ Fast queries
- ✅ No server cost
- ✅ Privacy (data stays local)
- ✅ Đã implement

**Cons:**
- ❌ No sync across devices (yet)
- ❌ Manual updates

**Implementation:**
```sql
-- Extend current schema
CREATE TABLE nutrition_facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  food_item_id INTEGER,
  calories REAL,
  protein REAL,
  fat REAL,
  carbs REAL,
  fiber REAL,
  sugar REAL,
  sodium REAL,
  -- Vitamins
  vitamin_a REAL,
  vitamin_c REAL,
  vitamin_d REAL,
  vitamin_e REAL,
  vitamin_k REAL,
  vitamin_b1 REAL,
  vitamin_b2 REAL,
  vitamin_b3 REAL,
  vitamin_b6 REAL,
  vitamin_b12 REAL,
  folate REAL,
  -- Minerals
  calcium REAL,
  iron REAL,
  magnesium REAL,
  phosphorus REAL,
  potassium REAL,
  zinc REAL,
  -- Metadata
  serving_size REAL,
  serving_unit TEXT,
  health_score INTEGER, -- 0-100
  allergens TEXT, -- comma-separated
  diet_tags TEXT, -- vegan,keto,etc
  FOREIGN KEY (food_item_id) REFERENCES foods(id)
);

CREATE TABLE vitamins (
  id INTEGER PRIMARY KEY,
  code TEXT UNIQUE, -- A, B1, B2, C, D, etc
  name TEXT, -- Vitamin A, Thiamin, etc
  name_vi TEXT, -- Vitamin A, Thiamin, etc
  benefits TEXT, -- Health benefits
  benefits_vi TEXT,
  rda_male REAL, -- Recommended Daily Allowance
  rda_female REAL,
  unit TEXT -- mg, mcg, IU
);

CREATE TABLE minerals (
  id INTEGER PRIMARY KEY,
  code TEXT UNIQUE, -- Ca, Fe, Mg, etc
  name TEXT,
  name_vi TEXT,
  benefits TEXT,
  benefits_vi TEXT,
  rda_male REAL,
  rda_female REAL,
  unit TEXT
);
```

#### Option 2: Firebase Firestore (Future - Cloud Sync)

**Pros:**
- ✅ Real-time sync
- ✅ Multi-device
- ✅ Backup tự động
- ✅ Free tier: 50K reads/day, 20K writes/day

**Cons:**
- ❌ Requires internet
- ❌ Privacy concerns
- ❌ Phức tạp hơn

**Free Tier:**
- 1 GB storage
- 50K document reads/day (đủ cho 1K users active)
- 20K document writes/day

#### Option 3: Supabase (PostgreSQL + Real-time)

**Pros:**
- ✅ PostgreSQL (powerful queries)
- ✅ Row Level Security
- ✅ Real-time subscriptions
- ✅ Free tier: 500MB DB, 2GB bandwidth

**Cons:**
- ❌ Requires internet
- ❌ Learning curve

---

## 4. CHỨC NĂNG CẦN PHÁT TRIỂN

### 🎯 Priority 1: Core Nutrition Features

#### 4.1 Nutrition Facts Display

**Screen:** Food Detail Screen (expand)

**UI Components:**
```dart
// Nutrition Facts Card
NutritionFactsCard(
  calories: 52,
  protein: 2.6,
  fat: 0.2,
  carbs: 3.9,
  fiber: 1.2,
  servingSize: 100,
  servingUnit: 'g',
)

// Vitamins Grid
VitaminsGrid(
  vitamins: [
    VitaminData(code: 'C', value: 13.7, unit: 'mg', rda: 75, benefits: '...'),
    VitaminData(code: 'A', value: 833, unit: 'IU', rda: 3000, benefits: '...'),
  ],
)

// Minerals Grid
MineralsGrid(...)
```

**Design:**
- Nutrition label style (FDA format)
- Progress bars cho % RDA
- Color-coded (green = good, yellow = moderate, red = high)
- Tap to expand benefits

#### 4.2 Health Score & Analysis

**Algorithm:**
```dart
class HealthScoreCalculator {
  int calculateScore(NutritionFacts nutrition) {
    int score = 100;

    // Positive points
    score += (nutrition.fiber * 2).clamp(0, 10).toInt();
    score += (nutrition.protein * 1).clamp(0, 10).toInt();
    score += (nutrition.vitaminsCount * 2).clamp(0, 20).toInt();

    // Negative points
    score -= (nutrition.sugar / 5).clamp(0, 20).toInt();
    score -= (nutrition.sodium / 500).clamp(0, 20).toInt();
    score -= (nutrition.saturatedFat / 2).clamp(0, 15).toInt();

    return score.clamp(0, 100);
  }

  HealthRating getRating(int score) {
    if (score >= 80) return HealthRating.excellent;
    if (score >= 60) return HealthRating.good;
    if (score >= 40) return HealthRating.moderate;
    return HealthRating.poor;
  }
}
```

**UI:**
```
┌─────────────────────────────────┐
│  Health Score                   │
│  ═══════════════════════         │
│  85 / 100  🌟 Excellent         │
│                                 │
│  ✅ High in fiber               │
│  ✅ Good source of Vitamin C    │
│  ✅ Low in sugar                │
│  ⚠️  Moderate sodium            │
└─────────────────────────────────┘
```

#### 4.3 Vitamin/Mineral Tracker

**New Screen:** Nutrition Dashboard

**Features:**
- Daily intake tracking
- % of RDA met
- Charts (pie, bar graphs)
- Recommendations

**UI Mockup:**
```
Dinh Dưỡng Hôm Nay
━━━━━━━━━━━━━━━━━━━

Calories: 1,456 / 2,000 kcal  [========   ] 73%

Macros:
- Protein:    45g / 60g     [=======    ] 75%
- Carbs:     180g / 250g    [=======    ] 72%
- Fat:        48g / 65g     [=======    ] 74%

Top Vitamins:
🥕 Vitamin A   120% RDA  ✅
🍊 Vitamin C    95% RDA  ✅
🥛 Calcium      68% RDA  ⚠️
🥩 Iron         42% RDA  ❌

Suggestions:
💡 Bạn nên ăn thêm thực phẩm giàu Iron (thịt đỏ, rau bina)
```

#### 4.4 Smart Recommendations

**Context-Aware Suggestions:**

```dart
class RecommendationEngine {
  List<FoodSuggestion> getRecommendations(UserProfile user) {
    List<FoodSuggestion> suggestions = [];

    // Based on nutritional gaps
    if (user.calciumIntake < user.calciumRDA * 0.7) {
      suggestions.add(FoodSuggestion(
        reason: 'Low calcium',
        foods: ['Sữa tươi', 'Phô mai', 'Rau cải'],
        priority: Priority.high,
      ));
    }

    // Based on expiring foods
    final expiring = getExpiringFoods();
    if (expiring.isNotEmpty) {
      suggestions.add(FoodSuggestion(
        reason: 'Foods expiring soon',
        foods: expiring,
        action: 'Cook these first!',
        recipes: getRecipesFor(expiring),
      ));
    }

    // Based on health goals
    if (user.goal == HealthGoal.loseWeight) {
      suggestions.add(FoodSuggestion(
        reason: 'Low calorie options',
        foods: getLowCalorieFoods(),
      ));
    }

    return suggestions;
  }
}
```

**UI Examples:**

```
┌─────────────────────────────────┐
│  💡 Suggestions For You         │
├─────────────────────────────────┤
│  🥛 Boost Your Calcium          │
│  You're at 60% of daily goal   │
│  Try: Sữa tươi, Phô mai, Đậu   │
│                   [Add to Cart] │
├─────────────────────────────────┤
│  ⏰ Expiring Soon               │
│  2 cà chua, 1 dưa chuột         │
│  Recipe: Salad cà chua dưa leo  │
│                    [View Recipe]│
└─────────────────────────────────┘
```

#### 4.5 Recipe Suggestions

**Integration với Expiring Foods:**

```dart
class RecipeService {
  Future<List<Recipe>> getRecipesFromIngredients(
    List<FoodItem> foods
  ) async {
    // Call Edamam Recipe Search API
    final ingredients = foods.map((f) => f.name).join(',');

    final response = await http.get(
      'https://api.edamam.com/search'
      '?q=$ingredients'
      '&app_id=$appId'
      '&app_key=$appKey'
      '&to=10'
    );

    return parseRecipes(response.data);
  }
}
```

**UI:**
```
┌─────────────────────────────────┐
│  🍳 Recipes You Can Make        │
├─────────────────────────────────┤
│  [IMG] Salad Cà Chua            │
│  ⏱️  10 mins  👤 2 servings    │
│  Uses: Cà chua, Dưa chuột      │
│                    [View Recipe]│
├─────────────────────────────────┤
│  [IMG] Canh Rau Củ              │
│  ⏱️  20 mins  👤 4 servings    │
│  Uses: Cà rốt, Khoai tây       │
│                    [View Recipe]│
└─────────────────────────────────┘
```

### 🎯 Priority 2: Enhanced Features

#### 4.6 Shopping List with Nutrition Goals

**New Screen:** Shopping List

**Features:**
- Smart suggestions based on:
  - Nutritional gaps
  - Empty categories
  - Expiring soon
  - User preferences
- Group by category
- Check off items
- Add nutrition target (e.g., "High protein foods")

**UI:**
```
Shopping List  [+ Add Item]

🎯 Goal: High Protein

To Buy:
☐ Thịt gà (500g)        Protein: 31g/100g
☐ Trứng (10 quả)        Protein: 13g/egg
☐ Đậu phụ (1 miếng)     Protein: 8g/100g

Suggested:
💡 Sữa tươi - Good for calcium
💡 Cá hồi - High in Omega-3
```

#### 4.7 Meal Planning

**New Screen:** Meal Planner

**Features:**
- Weekly meal calendar
- Drag-drop food items
- Nutrition summary per meal/day
- Export grocery list
- Recipe integration

#### 4.8 Food Waste Analytics

**Dashboard Features:**
- Total food wasted (kg)
- Money wasted estimate
- Most wasted category
- Suggestions to reduce waste
- Charts & trends

**UI:**
```
┌─────────────────────────────────┐
│  Food Waste This Month          │
│                                 │
│  1.2 kg wasted  (~200,000 VNĐ) │
│  ▓▓▓▓▓░░░░░                    │
│  -15% vs last month ✅          │
│                                 │
│  Most Wasted:                  │
│  🥬 Rau củ (45%)               │
│  🍅 Trái cây (30%)             │
│  🥛 Sữa (15%)                  │
│                                 │
│  💡 Tip: Freeze vegetables     │
│  before they expire             │
└─────────────────────────────────┘
```

#### 4.9 Diet Mode Filters

**Supported Diets:**
- Vegan 🌱
- Vegetarian 🥗
- Keto 🥑
- Low-Carb
- High-Protein
- Gluten-Free 🌾
- Lactose-Free 🥛
- Halal ☪️

**Implementation:**
```dart
enum DietType {
  vegan,
  vegetarian,
  keto,
  lowCarb,
  highProtein,
  glutenFree,
  lactoseFree,
  halal,
}

class FoodItem {
  // ...
  bool isCompatibleWith(DietType diet) {
    switch (diet) {
      case DietType.vegan:
        return !containsAnimalProducts;
      case DietType.keto:
        return carbs < 5; // per 100g
      // etc.
    }
  }
}
```

#### 4.10 Allergen Warnings

**Features:**
- User sets allergies in profile
- Warning badge on foods
- Filter out allergens
- Substitute suggestions

**UI:**
```
⚠️  ALLERGEN WARNING
This food contains: Gluten, Milk
You are allergic to: Milk

Alternative suggestions:
- Sữa hạnh nhân (Almond milk)
- Sữa yến mạch (Oat milk)
```

---

## 5. KIẾN TRÚC & DATABASE

### 📐 Extended Architecture

```
lib/
├── features/
│   ├── nutrition/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── usda_api_datasource.dart
│   │   │   │   ├── nutrition_local_datasource.dart
│   │   │   │   └── nutrition_cache_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── nutrition_facts_model.dart
│   │   │   │   ├── vitamin_model.dart
│   │   │   │   └── mineral_model.dart
│   │   │   └── repositories/
│   │   │       └── nutrition_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── nutrition_facts.dart
│   │   │   │   ├── vitamin.dart
│   │   │   │   └── health_score.dart
│   │   │   ├── repositories/
│   │   │   │   └── nutrition_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_nutrition_facts.dart
│   │   │       ├── calculate_health_score.dart
│   │   │       └── get_daily_nutrition.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── nutrition_provider.dart
│   │       ├── screens/
│   │       │   ├── nutrition_detail_screen.dart
│   │       │   ├── nutrition_dashboard_screen.dart
│   │       │   └── health_analysis_screen.dart
│   │       └── widgets/
│   │           ├── nutrition_facts_card.dart
│   │           ├── vitamins_grid.dart
│   │           ├── health_score_badge.dart
│   │           └── macro_chart.dart
│   │
│   ├── recommendations/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── food_suggestion.dart
│   │   │   └── usecases/
│   │   │       ├── get_recommendations.dart
│   │   │       └── get_recipe_suggestions.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── recommendations_screen.dart
│   │       └── widgets/
│   │           └── suggestion_card.dart
│   │
│   ├── shopping_list/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── meal_planning/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── analytics/
│       ├── domain/
│       │   └── usecases/
│       │       ├── calculate_food_waste.dart
│       │       └── generate_waste_report.dart
│       └── presentation/
│           └── screens/
│               └── analytics_screen.dart
│
└── services/
    ├── usda_api_service.dart
    ├── edamam_recipe_service.dart
    └── nutrition_calculation_service.dart
```

### 🗄️ Extended Database Schema

```sql
-- Current tables (keep as is)
-- foods, settings

-- New tables

-- Nutrition facts for each food
CREATE TABLE nutrition_facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  food_id INTEGER NOT NULL,

  -- Macros (per 100g)
  calories REAL DEFAULT 0,
  protein REAL DEFAULT 0,
  fat REAL DEFAULT 0,
  saturated_fat REAL DEFAULT 0,
  trans_fat REAL DEFAULT 0,
  carbohydrates REAL DEFAULT 0,
  fiber REAL DEFAULT 0,
  sugar REAL DEFAULT 0,
  sodium REAL DEFAULT 0,
  cholesterol REAL DEFAULT 0,

  -- Vitamins (per 100g)
  vitamin_a REAL DEFAULT 0,      -- mcg
  vitamin_b1 REAL DEFAULT 0,     -- mg (Thiamin)
  vitamin_b2 REAL DEFAULT 0,     -- mg (Riboflavin)
  vitamin_b3 REAL DEFAULT 0,     -- mg (Niacin)
  vitamin_b5 REAL DEFAULT 0,     -- mg (Pantothenic acid)
  vitamin_b6 REAL DEFAULT 0,     -- mg
  vitamin_b7 REAL DEFAULT 0,     -- mcg (Biotin)
  vitamin_b9 REAL DEFAULT 0,     -- mcg (Folate)
  vitamin_b12 REAL DEFAULT 0,    -- mcg
  vitamin_c REAL DEFAULT 0,      -- mg
  vitamin_d REAL DEFAULT 0,      -- mcg
  vitamin_e REAL DEFAULT 0,      -- mg
  vitamin_k REAL DEFAULT 0,      -- mcg

  -- Minerals (per 100g)
  calcium REAL DEFAULT 0,        -- mg
  iron REAL DEFAULT 0,           -- mg
  magnesium REAL DEFAULT 0,      -- mg
  phosphorus REAL DEFAULT 0,     -- mg
  potassium REAL DEFAULT 0,      -- mg
  zinc REAL DEFAULT 0,           -- mg
  copper REAL DEFAULT 0,         -- mg
  manganese REAL DEFAULT 0,      -- mg
  selenium REAL DEFAULT 0,       -- mcg

  -- Serving info
  serving_size REAL DEFAULT 100, -- grams
  serving_unit TEXT DEFAULT 'g',

  -- Health metadata
  health_score INTEGER DEFAULT 50, -- 0-100
  allergens TEXT,                  -- JSON array: ["gluten","milk"]
  diet_tags TEXT,                  -- JSON array: ["vegan","keto"]

  -- Data source
  data_source TEXT,                -- 'usda', 'openfoodfacts', 'manual'
  source_id TEXT,                  -- External API ID
  last_updated INTEGER,            -- Timestamp

  FOREIGN KEY (food_id) REFERENCES foods(id) ON DELETE CASCADE
);

-- Reference data: Vitamins
CREATE TABLE vitamin_info (
  code TEXT PRIMARY KEY,           -- 'A', 'B1', 'C', etc.
  name TEXT NOT NULL,              -- 'Vitamin A'
  name_vi TEXT,                    -- 'Vitamin A'

  -- Benefits
  benefits TEXT,                   -- English description
  benefits_vi TEXT,                -- Vietnamese description

  -- RDA (Recommended Daily Allowance)
  rda_male REAL,                   -- For adult males
  rda_female REAL,                 -- For adult females
  rda_pregnant REAL,               -- For pregnant women
  rda_lactating REAL,              -- For lactating women
  unit TEXT NOT NULL,              -- 'mg', 'mcg', 'IU'

  -- Display
  icon TEXT,                       -- Emoji or icon name
  color TEXT                       -- Hex color for UI
);

-- Reference data: Minerals
CREATE TABLE mineral_info (
  code TEXT PRIMARY KEY,           -- 'Ca', 'Fe', 'Mg', etc.
  name TEXT NOT NULL,
  name_vi TEXT,
  benefits TEXT,
  benefits_vi TEXT,
  rda_male REAL,
  rda_female REAL,
  rda_pregnant REAL,
  rda_lactating REAL,
  unit TEXT NOT NULL,
  icon TEXT,
  color TEXT
);

-- User nutrition tracking
CREATE TABLE daily_nutrition (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL,              -- YYYY-MM-DD

  -- Totals for the day
  total_calories REAL DEFAULT 0,
  total_protein REAL DEFAULT 0,
  total_fat REAL DEFAULT 0,
  total_carbs REAL DEFAULT 0,
  total_fiber REAL DEFAULT 0,

  -- Calculated from foods consumed
  foods_consumed TEXT,             -- JSON array of food IDs

  created_at INTEGER,
  updated_at INTEGER
);

-- User dietary preferences & goals
CREATE TABLE user_profile (
  id INTEGER PRIMARY KEY CHECK (id = 1), -- Single row

  -- Personal info
  gender TEXT DEFAULT 'female',    -- 'male', 'female', 'other'
  age INTEGER,
  weight REAL,                     -- kg
  height REAL,                     -- cm
  activity_level TEXT,             -- 'sedentary', 'moderate', 'active'

  -- Dietary preferences
  diet_type TEXT,                  -- 'regular', 'vegan', 'keto', etc.
  allergies TEXT,                  -- JSON array: ["gluten","peanuts"]

  -- Goals
  health_goal TEXT,                -- 'maintain', 'lose_weight', 'gain_muscle'
  calorie_goal REAL,
  protein_goal REAL,
  carb_goal REAL,
  fat_goal REAL,

  -- Preferences
  preferred_cuisines TEXT,         -- JSON array
  disliked_foods TEXT,             -- JSON array

  created_at INTEGER,
  updated_at INTEGER
);

-- Shopping list
CREATE TABLE shopping_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  category TEXT,
  quantity REAL,
  unit TEXT,
  checked INTEGER DEFAULT 0,       -- Boolean
  nutrition_target TEXT,           -- 'high_protein', 'low_calorie', etc.
  notes TEXT,
  added_date INTEGER,
  checked_date INTEGER
);

-- Meal planning
CREATE TABLE meal_plans (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL,              -- YYYY-MM-DD
  meal_type TEXT NOT NULL,         -- 'breakfast', 'lunch', 'dinner', 'snack'
  food_id INTEGER,
  recipe_id INTEGER,
  servings REAL DEFAULT 1,
  notes TEXT,
  created_at INTEGER,
  FOREIGN KEY (food_id) REFERENCES foods(id) ON DELETE CASCADE
);

-- Recipes
CREATE TABLE recipes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  name_vi TEXT,
  description TEXT,
  description_vi TEXT,

  -- Recipe details
  prep_time INTEGER,               -- minutes
  cook_time INTEGER,
  servings INTEGER,
  difficulty TEXT,                 -- 'easy', 'medium', 'hard'

  -- Ingredients
  ingredients TEXT NOT NULL,       -- JSON array
  instructions TEXT NOT NULL,      -- JSON array of steps

  -- Nutrition (per serving)
  calories REAL,
  protein REAL,
  carbs REAL,
  fat REAL,

  -- Metadata
  cuisine TEXT,
  tags TEXT,                       -- JSON array
  image_url TEXT,
  source_url TEXT,

  created_at INTEGER
);

-- Food waste tracking
CREATE TABLE food_waste (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  food_id INTEGER,
  food_name TEXT,
  category TEXT,
  quantity REAL,
  unit TEXT,
  reason TEXT,                     -- 'expired', 'spoiled', 'forgot', etc.
  estimated_cost REAL,             -- VND
  waste_date INTEGER,
  FOREIGN KEY (food_id) REFERENCES foods(id) ON DELETE SET NULL
);

-- Indexes for performance
CREATE INDEX idx_nutrition_facts_food_id ON nutrition_facts(food_id);
CREATE INDEX idx_daily_nutrition_date ON daily_nutrition(date);
CREATE INDEX idx_meal_plans_date ON meal_plans(date);
CREATE INDEX idx_shopping_items_checked ON shopping_items(checked);
CREATE INDEX idx_food_waste_waste_date ON food_waste(waste_date);
```

### 📊 Pre-populated Reference Data

**Insert Vitamin Info:**
```sql
INSERT INTO vitamin_info VALUES
  ('A', 'Vitamin A', 'Vitamin A',
   'Essential for vision, immune function, reproduction',
   'Cần thiết cho thị lực, miễn dịch, sinh sản',
   900, 700, 770, 1300, 'mcg', '🥕', '#FF9500'),
  ('B1', 'Thiamin (B1)', 'Thiamin (B1)',
   'Helps convert nutrients into energy',
   'Giúp chuyển đổi chất dinh dưỡng thành năng lượng',
   1.2, 1.1, 1.4, 1.4, 'mg', '🌾', '#F0E68C'),
  ('B2', 'Riboflavin (B2)', 'Riboflavin (B2)',
   'Helps convert food into energy, important for skin',
   'Chuyển hóa thức ăn thành năng lượng, tốt cho da',
   1.3, 1.1, 1.4, 1.6, 'mg', '🥛', '#FFE4B5'),
  -- ... more vitamins
  ('C', 'Vitamin C', 'Vitamin C',
   'Antioxidant, supports immune system, helps iron absorption',
   'Chống oxy hóa, tăng cường miễn dịch, hấp thụ sắt',
   90, 75, 85, 120, 'mg', '🍊', '#FF6B35'),
  ('D', 'Vitamin D', 'Vitamin D',
   'Essential for bone health, calcium absorption',
   'Cần thiết cho xương, hấp thụ canxi',
   15, 15, 15, 15, 'mcg', '☀️', '#FFD700'),
  ('E', 'Vitamin E', 'Vitamin E',
   'Antioxidant, protects cells from damage',
   'Chống oxy hóa, bảo vệ tế bào',
   15, 15, 15, 19, 'mg', '🥜', '#DEB887'),
  ('K', 'Vitamin K', 'Vitamin K',
   'Important for blood clotting and bone health',
   'Quan trọng cho đông máu và xương',
   120, 90, 90, 90, 'mcg', '🥬', '#228B22');
```

**Insert Mineral Info:**
```sql
INSERT INTO mineral_info VALUES
  ('Ca', 'Calcium', 'Canxi',
   'Builds and maintains strong bones and teeth',
   'Xây dựng và duy trì xương răng chắc khỏe',
   1000, 1000, 1000, 1000, 'mg', '🥛', '#FFFFFF'),
  ('Fe', 'Iron', 'Sắt',
   'Essential for blood production, oxygen transport',
   'Cần thiết cho sản xuất máu, vận chuyển oxy',
   8, 18, 27, 9, 'mg', '🥩', '#DC143C'),
  ('Mg', 'Magnesium', 'Magiê',
   'Supports muscle and nerve function, energy production',
   'Hỗ trợ cơ bắp và thần kinh, sản xuất năng lượng',
   400, 310, 350, 310, 'mg', '🌰', '#8B4513'),
  ('Zn', 'Zinc', 'Kẽm',
   'Supports immune system, wound healing, DNA synthesis',
   'Tăng cường miễn dịch, lành vết thương, tổng hợp DNA',
   11, 8, 11, 12, 'mg', '🦪', '#708090'),
  ('K', 'Potassium', 'Kali',
   'Regulates fluid balance, muscle contractions, nerve signals',
   'Điều hòa cân bằng nước, co cơ, tín hiệu thần kinh',
   3400, 2600, 2900, 2800, 'mg', '🍌', '#FFE135'),
  ('P', 'Phosphorus', 'Photpho',
   'Builds strong bones and teeth, helps produce energy',
   'Xây dựng xương răng, giúp sản xuất năng lượng',
   700, 700, 700, 700, 'mg', '🥚', '#FFDEAD');
```

---

## 6. CUSTOM SUBAGENTS

### Tạo Custom Subagents Cho Dự Án

#### 6.1 Nutrition Data Expert

**File:** `subagents/nutrition-data-expert.md`

**Purpose:** Expert in food nutrition data, APIs, and health analysis

**Responsibilities:**
- Integrate nutrition APIs (USDA, Open Food Facts)
- Calculate nutrition facts
- Health score algorithms
- RDA calculations
- Dietary recommendations

#### 6.2 UX/UI Designer (Already exists - extend)

**Enhancements needed:**
- Nutrition facts display design
- Health score visualizations
- Charts and graphs
- Data-heavy screens

#### 6.3 Flutter Expert (Already exists - extend)

**Enhancements needed:**
- Chart libraries (fl_chart)
- Complex state management for nutrition tracking
- API integration patterns
- Performance optimization for large datasets

---

## 7. ROADMAP PHÁT TRIỂN

### 📅 Phase 1: Foundation (Week 1-2)

**Goals:** Setup nutrition data infrastructure

**Tasks:**
1. ✅ Analyze current architecture
2. ✅ Design extended database schema
3. ⬜ Create database migrations
4. ⬜ Setup USDA API integration
5. ⬜ Create nutrition models & entities
6. ⬜ Implement nutrition repository
7. ⬜ Seed vitamin/mineral reference data

**Deliverables:**
- Extended SQLite schema
- USDA API service
- Nutrition domain models
- Reference data populated

### 📅 Phase 2: Core Features (Week 3-4)

**Goals:** Implement nutrition facts & health score

**Tasks:**
1. ⬜ Build NutritionFactsCard widget
2. ⬜ Implement health score calculator
3. ⬜ Create VitaminsGrid widget
4. ⬜ Create MineralsGrid widget
5. ⬜ Update AddFoodScreen with nutrition input
6. ⬜ Update FoodDetailScreen with nutrition display
7. ⬜ Implement nutrition caching

**Deliverables:**
- Nutrition facts display
- Health score badge
- Vitamin/mineral visualization
- Updated food detail screen

### 📅 Phase 3: Tracking & Analytics (Week 5-6)

**Goals:** Daily nutrition tracking & dashboard

**Tasks:**
1. ⬜ Create NutritionDashboardScreen
2. ⬜ Implement daily nutrition calculator
3. ⬜ Build macro/micro tracking
4. ⬜ Create progress charts (fl_chart)
5. ⬜ Implement RDA tracking
6. ⬜ Add nutrition goals setting
7. ⬜ Create food waste analytics

**Deliverables:**
- Nutrition dashboard
- Daily tracking
- Progress charts
- Waste analytics

### 📅 Phase 4: Intelligence Features (Week 7-8)

**Goals:** Recommendations & meal planning

**Tasks:**
1. ⬜ Implement recommendation engine
2. ⬜ Create RecommendationsScreen
3. ⬜ Build shopping list feature
4. ⬜ Integrate recipe API (Edamam)
5. ⬜ Create meal planner
6. ⬜ Implement diet mode filters
7. ⬜ Add allergen warnings

**Deliverables:**
- Smart recommendations
- Shopping list
- Recipe suggestions
- Meal planner
- Diet filters

### 📅 Phase 5: Polish & Optimize (Week 9-10)

**Goals:** UI/UX refinement, performance, testing

**Tasks:**
1. ⬜ UI/UX review and improvements
2. ⬜ Performance optimization
3. ⬜ Write unit tests
4. ⬜ Write widget tests
5. ⬜ User testing & feedback
6. ⬜ Bug fixes
7. ⬜ Documentation

**Deliverables:**
- Polished UI
- Optimized performance
- Test coverage
- Bug-free release

---

## 8. TECHNICAL IMPLEMENTATION

### 🔧 Step-by-Step Implementation Guide

#### Step 1: Setup USDA API Service

**Create:** `lib/services/usda_api_service.dart`

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class USDAApiService {
  static const String _baseUrl = 'https://api.nal.usda.gov/fdc/v1';
  static const String _apiKey = 'YOUR_API_KEY'; // Get from https://fdc.nal.usda.gov/api-key-signup.html

  static final USDAApiService instance = USDAApiService._init();
  USDAApiService._init();

  /// Search for foods
  Future<List<USDAFood>> searchFoods(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/foods/search')
            .replace(queryParameters: {
          'query': query,
          'api_key': _apiKey,
          'pageSize': '10',
          'dataType': 'Survey (FNDDS)', // Most comprehensive
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final foods = (data['foods'] as List)
            .map((food) => USDAFood.fromJson(food))
            .toList();
        return foods;
      } else {
        throw Exception('Failed to search foods: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching USDA foods: $e');
      return [];
    }
  }

  /// Get detailed nutrition facts for a food
  Future<NutritionFacts?> getNutritionFacts(String fdcId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/food/$fdcId')
            .replace(queryParameters: {
          'api_key': _apiKey,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NutritionFacts.fromUSDAJson(data);
      }
    } catch (e) {
      print('Error getting nutrition facts: $e');
    }
    return null;
  }
}

class USDAFood {
  final String fdcId;
  final String description;
  final String? category;

  USDAFood({
    required this.fdcId,
    required this.description,
    this.category,
  });

  factory USDAFood.fromJson(Map<String, dynamic> json) {
    return USDAFood(
      fdcId: json['fdcId'].toString(),
      description: json['description'] ?? '',
      category: json['foodCategory'],
    );
  }
}
```

#### Step 2: Create Nutrition Models

**Create:** `lib/models/nutrition_facts.dart`

```dart
class NutritionFacts {
  final int id;
  final int foodId;

  // Macros (per 100g)
  final double calories;
  final double protein;
  final double fat;
  final double saturatedFat;
  final double transFat;
  final double carbohydrates;
  final double fiber;
  final double sugar;
  final double sodium;
  final double cholesterol;

  // Vitamins (per 100g)
  final double vitaminA;
  final double vitaminB1;
  final double vitaminB2;
  final double vitaminB3;
  final double vitaminB6;
  final double vitaminB12;
  final double vitaminC;
  final double vitaminD;
  final double vitaminE;
  final double vitaminK;
  final double folate;

  // Minerals (per 100g)
  final double calcium;
  final double iron;
  final double magnesium;
  final double phosphorus;
  final double potassium;
  final double zinc;

  // Metadata
  final double servingSize;
  final String servingUnit;
  final int healthScore;
  final List<String> allergens;
  final List<String> dietTags;
  final String dataSource;
  final String? sourceId;

  NutritionFacts({
    required this.id,
    required this.foodId,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.saturatedFat,
    required this.transFat,
    required this.carbohydrates,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.cholesterol,
    required this.vitaminA,
    required this.vitaminB1,
    required this.vitaminB2,
    required this.vitaminB3,
    required this.vitaminB6,
    required this.vitaminB12,
    required this.vitaminC,
    required this.vitaminD,
    required this.vitaminE,
    required this.vitaminK,
    required this.folate,
    required this.calcium,
    required this.iron,
    required this.magnesium,
    required this.phosphorus,
    required this.potassium,
    required this.zinc,
    required this.servingSize,
    required this.servingUnit,
    required this.healthScore,
    required this.allergens,
    required this.dietTags,
    required this.dataSource,
    this.sourceId,
  });

  /// Parse from USDA API response
  factory NutritionFacts.fromUSDAJson(Map<String, dynamic> json) {
    final nutrients = json['foodNutrients'] as List;

    // Helper to extract nutrient value by name
    double getNutrient(String name) {
      try {
        final nutrient = nutrients.firstWhere(
          (n) => (n['nutrient']['name'] as String).toLowerCase().contains(name.toLowerCase()),
          orElse: () => null,
        );
        return nutrient != null ? (nutrient['amount'] as num).toDouble() : 0.0;
      } catch (e) {
        return 0.0;
      }
    }

    return NutritionFacts(
      id: 0, // Will be set by database
      foodId: 0,
      calories: getNutrient('Energy'),
      protein: getNutrient('Protein'),
      fat: getNutrient('Total lipid (fat)'),
      saturatedFat: getNutrient('Fatty acids, total saturated'),
      transFat: getNutrient('Fatty acids, total trans'),
      carbohydrates: getNutrient('Carbohydrate'),
      fiber: getNutrient('Fiber'),
      sugar: getNutrient('Sugars, total'),
      sodium: getNutrient('Sodium'),
      cholesterol: getNutrient('Cholesterol'),
      vitaminA: getNutrient('Vitamin A'),
      vitaminB1: getNutrient('Thiamin'),
      vitaminB2: getNutrient('Riboflavin'),
      vitaminB3: getNutrient('Niacin'),
      vitaminB6: getNutrient('Vitamin B-6'),
      vitaminB12: getNutrient('Vitamin B-12'),
      vitaminC: getNutrient('Vitamin C'),
      vitaminD: getNutrient('Vitamin D'),
      vitaminE: getNutrient('Vitamin E'),
      vitaminK: getNutrient('Vitamin K'),
      folate: getNutrient('Folate'),
      calcium: getNutrient('Calcium'),
      iron: getNutrient('Iron'),
      magnesium: getNutrient('Magnesium'),
      phosphorus: getNutrient('Phosphorus'),
      potassium: getNutrient('Potassium'),
      zinc: getNutrient('Zinc'),
      servingSize: 100,
      servingUnit: 'g',
      healthScore: 50, // Calculate later
      allergens: [],
      dietTags: [],
      dataSource: 'usda',
      sourceId: json['fdcId'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'food_id': foodId,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'saturated_fat': saturatedFat,
      'trans_fat': transFat,
      'carbohydrates': carbohydrates,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'cholesterol': cholesterol,
      'vitamin_a': vitaminA,
      'vitamin_b1': vitaminB1,
      'vitamin_b2': vitaminB2,
      'vitamin_b3': vitaminB3,
      'vitamin_b6': vitaminB6,
      'vitamin_b12': vitaminB12,
      'vitamin_c': vitaminC,
      'vitamin_d': vitaminD,
      'vitamin_e': vitaminE,
      'vitamin_k': vitaminK,
      'folate': folate,
      'calcium': calcium,
      'iron': iron,
      'magnesium': magnesium,
      'phosphorus': phosphorus,
      'potassium': potassium,
      'zinc': zinc,
      'serving_size': servingSize,
      'serving_unit': servingUnit,
      'health_score': healthScore,
      'allergens': allergens.join(','),
      'diet_tags': dietTags.join(','),
      'data_source': dataSource,
      'source_id': sourceId,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory NutritionFacts.fromMap(Map<String, dynamic> map) {
    return NutritionFacts(
      id: map['id'] ?? 0,
      foodId: map['food_id'] ?? 0,
      calories: map['calories']?.toDouble() ?? 0.0,
      protein: map['protein']?.toDouble() ?? 0.0,
      fat: map['fat']?.toDouble() ?? 0.0,
      saturatedFat: map['saturated_fat']?.toDouble() ?? 0.0,
      transFat: map['trans_fat']?.toDouble() ?? 0.0,
      carbohydrates: map['carbohydrates']?.toDouble() ?? 0.0,
      fiber: map['fiber']?.toDouble() ?? 0.0,
      sugar: map['sugar']?.toDouble() ?? 0.0,
      sodium: map['sodium']?.toDouble() ?? 0.0,
      cholesterol: map['cholesterol']?.toDouble() ?? 0.0,
      vitaminA: map['vitamin_a']?.toDouble() ?? 0.0,
      vitaminB1: map['vitamin_b1']?.toDouble() ?? 0.0,
      vitaminB2: map['vitamin_b2']?.toDouble() ?? 0.0,
      vitaminB3: map['vitamin_b3']?.toDouble() ?? 0.0,
      vitaminB6: map['vitamin_b6']?.toDouble() ?? 0.0,
      vitaminB12: map['vitamin_b12']?.toDouble() ?? 0.0,
      vitaminC: map['vitamin_c']?.toDouble() ?? 0.0,
      vitaminD: map['vitamin_d']?.toDouble() ?? 0.0,
      vitaminE: map['vitamin_e']?.toDouble() ?? 0.0,
      vitaminK: map['vitamin_k']?.toDouble() ?? 0.0,
      folate: map['folate']?.toDouble() ?? 0.0,
      calcium: map['calcium']?.toDouble() ?? 0.0,
      iron: map['iron']?.toDouble() ?? 0.0,
      magnesium: map['magnesium']?.toDouble() ?? 0.0,
      phosphorus: map['phosphorus']?.toDouble() ?? 0.0,
      potassium: map['potassium']?.toDouble() ?? 0.0,
      zinc: map['zinc']?.toDouble() ?? 0.0,
      servingSize: map['serving_size']?.toDouble() ?? 100.0,
      servingUnit: map['serving_unit'] ?? 'g',
      healthScore: map['health_score'] ?? 50,
      allergens: (map['allergens'] as String?)?.split(',') ?? [],
      dietTags: (map['diet_tags'] as String?)?.split(',') ?? [],
      dataSource: map['data_source'] ?? 'manual',
      sourceId: map['source_id'],
    );
  }
}

class Vitamin {
  final String code;
  final String name;
  final String nameVi;
  final String benefits;
  final String benefitsVi;
  final double rdaMale;
  final double rdaFemale;
  final String unit;
  final String icon;
  final String color;

  Vitamin({
    required this.code,
    required this.name,
    required this.nameVi,
    required this.benefits,
    required this.benefitsVi,
    required this.rdaMale,
    required this.rdaFemale,
    required this.unit,
    required this.icon,
    required this.color,
  });

  factory Vitamin.fromMap(Map<String, dynamic> map) {
    return Vitamin(
      code: map['code'],
      name: map['name'],
      nameVi: map['name_vi'],
      benefits: map['benefits'],
      benefitsVi: map['benefits_vi'],
      rdaMale: map['rda_male']?.toDouble() ?? 0.0,
      rdaFemale: map['rda_female']?.toDouble() ?? 0.0,
      unit: map['unit'],
      icon: map['icon'],
      color: map['color'],
    );
  }
}

class Mineral {
  final String code;
  final String name;
  final String nameVi;
  final String benefits;
  final String benefitsVi;
  final double rdaMale;
  final double rdaFemale;
  final String unit;
  final String icon;
  final String color;

  Mineral({
    required this.code,
    required this.name,
    required this.nameVi,
    required this.benefits,
    required this.benefitsVi,
    required this.rdaMale,
    required this.rdaFemale,
    required this.unit,
    required this.icon,
    required this.color,
  });

  factory Mineral.fromMap(Map<String, dynamic> map) {
    return Mineral(
      code: map['code'],
      name: map['name'],
      nameVi: map['name_vi'],
      benefits: map['benefits'],
      benefitsVi: map['benefits_vi'],
      rdaMale: map['rda_male']?.toDouble() ?? 0.0,
      rdaFemale: map['rda_female']?.toDouble() ?? 0.0,
      unit: map['unit'],
      icon: map['icon'],
      color: map['color'],
    );
  }
}
```

### Continue in Part 2...

(Document is getting too long - will continue with UI widgets, database helper extensions, and complete implementation guide)

---

## 📌 SUMMARY & NEXT STEPS

### ✅ What We Analyzed

1. **Current State:**
   - Fully functional food management app
   - 95-item food database with shelf life data
   - Smart autocomplete working
   - SQLite + Provider architecture

2. **User Requirements:**
   - Health analysis features
   - Vitamin/mineral information
   - Smart recommendations
   - Nutrition tracking

3. **Data Sources:**
   - USDA FoodData Central API (FREE, unlimited, recommended)
   - Open Food Facts API (already integrated)
   - Local SQLite for offline-first

4. **Features to Build:**
   - Nutrition facts display
   - Health score calculator
   - Daily nutrition dashboard
   - Smart recommendations
   - Shopping list
   - Recipe suggestions
   - Meal planning

### 🎯 Immediate Next Steps

1. **Setup API:**
   - Register for USDA API key
   - Test API endpoints
   - Create service class

2. **Database Migration:**
   - Create migration script
   - Add new tables
   - Seed reference data

3. **UI Mockups:**
   - Design nutrition facts card
   - Design health score badge
   - Design dashboard layout

4. **Development:**
   - Follow roadmap phases
   - Use subagents for specialized tasks
   - Test incrementally

### 📚 Resources Created

- ✅ Complete architecture analysis
- ✅ Database schema design
- ✅ API integration guide
- ✅ Feature specifications
- ✅ Implementation roadmap
- ✅ Code examples

---

**Ready to build an amazing nutrition-focused fridge tracker app! 🚀🥗💪**
