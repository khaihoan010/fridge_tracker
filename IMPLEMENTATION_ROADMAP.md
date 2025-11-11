# 🚀 IMPLEMENTATION ROADMAP - FRIDGE TRACKER

> Lộ trình triển khai chi tiết cho các tính năng nutrition mới

---

## 📊 TÓM TẮT HIỆN TRẠNG

### ✅ Đã Có (Ready to Build On)

**Core Features:**
- ✅ Food management CRUD (SQLite + Provider)
- ✅ 95-item food database với shelf life data
- ✅ Smart autocomplete (Vietnamese fuzzy search)
- ✅ Auto-calculation ngày hết hạn
- ✅ Barcode scanning (Open Food Facts)
- ✅ Expiry notifications
- ✅ V2 Design System (feminine, modern)

**Tech Stack:**
- Flutter 3.8.1+
- SQLite local database
- Provider state management
- Open Food Facts API (barcode)

### 🎯 Yêu Cầu Mới

1. **Phân tích/Đánh giá sản phẩm tốt cho sức khỏe**
2. **Cung cấp thông tin vitamin & minerals**
3. **Smart recommendations** (enhanced)
4. **Nutrition tracking dashboard**

---

## 📦 DELIVERABLES CREATED

Tôi đã tạo sẵn các documents sau để guide implementation:

### 1. 📄 COMPREHENSIVE_ANALYSIS.md
**Nội dung:**
- ✅ Phân tích chi tiết app hiện tại
- ✅ Yêu cầu mới từ user
- ✅ **Nguồn dữ liệu** (USDA API, Open Food Facts)
- ✅ **Database schema** mới (SQLite extended)
- ✅ **Các chức năng cần phát triển** (Priority 1 & 2)
- ✅ **Code examples** đầy đủ
- ✅ **Roadmap 10 tuần**

### 2. 📄 subagents/nutrition-data-expert.md
**Nội dung:**
- ✅ Nutrition API integration guide
- ✅ Health score algorithm (code sẵn)
- ✅ RDA calculations
- ✅ Dietary compatibility logic
- ✅ Unit conversions
- ✅ Best practices

### 3. 📄 Existing Subagents (Có Sẵn)
- ✅ `subagents/flutter-expert.md` - Flutter development
- ✅ `subagents/uiux-designer.md` - UI/UX design
- ✅ `subagents/backend-architect.md` - Architecture
- ✅ `subagents/README.md` - How to use subagents

---

## 🎯 NGUỒN DỮ LIỆU (DATA SOURCES)

### 🌐 API Chính: USDA FoodData Central ⭐️ RECOMMENDED

**Tại sao chọn USDA?**
- ✅ **MIỄN PHÍ hoàn toàn** - Unlimited requests với API key
- ✅ **Chính xác nhất** - Dữ liệu chính phủ Mỹ, chuẩn khoa học
- ✅ **400,000+ foods** - Database khổng lồ
- ✅ **Full nutrition data** - Calories, macros, 28+ vitamins/minerals
- ✅ **JSON API** - Dễ integrate

**Cách Lấy API Key:**
1. Vào: https://fdc.nal.usda.gov/api-key-signup.html
2. Đăng ký email (miễn phí, tức thì)
3. Nhận API key qua email
4. Không giới hạn requests!

**Example API Call:**
```bash
# Search for "tomato"
curl "https://api.nal.usda.gov/fdc/v1/foods/search?query=tomato&api_key=YOUR_KEY"

# Get nutrition details
curl "https://api.nal.usda.gov/fdc/v1/food/168462?api_key=YOUR_KEY"
```

**Response Example:**
```json
{
  "fdcId": 168462,
  "description": "Tomatoes, red, ripe, raw",
  "foodNutrients": [
    {
      "nutrientName": "Protein",
      "value": 0.9,
      "unitName": "g"
    },
    {
      "nutrientName": "Vitamin C, total ascorbic acid",
      "value": 13.7,
      "unitName": "mg"
    }
  ]
}
```

### 🌐 API Phụ: Open Food Facts (Đã Có)
- ✅ Đã integrate cho barcode scanning
- ✅ Mở rộng để lấy nutrition data
- ✅ 2.8 million products

### 💾 Local Database: SQLite Extended
- ✅ Offline-first approach
- ✅ Extend current schema với nutrition tables
- ✅ Pre-populate với Vietnamese foods
- ✅ Cache API results

**Cost:** $0 - Hoàn toàn miễn phí!

---

## 🏗️ KIẾN TRÚC MỚI

### Database Schema (Extended)

**New Tables:**
```sql
nutrition_facts       -- Nutrition data cho mỗi food
vitamin_info         -- Reference data: Vitamins
mineral_info         -- Reference data: Minerals
daily_nutrition      -- Daily tracking
user_profile         -- User preferences & goals
shopping_items       -- Shopping list
meal_plans          -- Meal planning
recipes             -- Recipe database
food_waste          -- Waste tracking
```

**Total Size Estimate:**
- Base schema: ~1KB
- Vitamin/mineral reference: ~5KB
- 1000 foods with nutrition: ~2-3MB
- Acceptable for mobile app ✅

### Code Structure (New)

```
lib/
├── features/
│   ├── nutrition/          # NEW
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── recommendations/    # NEW
│   ├── shopping_list/      # NEW
│   ├── meal_planning/      # NEW
│   └── analytics/          # NEW
└── services/
    ├── usda_api_service.dart           # NEW
    ├── nutrition_calculation_service.dart  # NEW
    └── edamam_recipe_service.dart      # NEW (Optional)
```

---

## 📅 ROADMAP CHI TIẾT

### 🚀 Phase 1: Foundation (Week 1-2)
**Mục tiêu:** Setup nutrition data infrastructure

**Tasks:**
1. ⬜ Register USDA API key
2. ⬜ Create database migration script
3. ⬜ Add new tables to SQLite
4. ⬜ Seed vitamin/mineral reference data
5. ⬜ Create `USDAApiService` class
6. ⬜ Create `NutritionFacts` model
7. ⬜ Create `Vitamin` & `Mineral` models
8. ⬜ Test API integration

**Estimated Time:** 10-15 hours

**Files to Create:**
- `lib/services/usda_api_service.dart`
- `lib/models/nutrition_facts.dart`
- `lib/models/vitamin.dart`
- `lib/models/mineral.dart`
- `lib/database/migrations/add_nutrition_tables.dart`
- `assets/data/vitamins.json`
- `assets/data/minerals.json`

**Subagents to Use:**
- `@nutrition-data-expert` - API integration
- `@flutter-expert` - Flutter code structure
- `@backend-architect` - Database design

### 🎨 Phase 2: Core UI (Week 3-4)
**Mục tiêu:** Hiển thị nutrition facts & health score

**Tasks:**
1. ⬜ Design `NutritionFactsCard` widget
2. ⬜ Design `HealthScoreBadge` widget
3. ⬜ Design `VitaminsGrid` widget
4. ⬜ Design `MineralsGrid` widget
5. ⬜ Update `FoodDetailScreen` layout
6. ⬜ Update `AddFoodScreen` with nutrition search
7. ⬜ Implement health score calculator
8. ⬜ Add nutrition data to food database

**Estimated Time:** 15-20 hours

**Files to Create:**
- `lib/widgets/nutrition/nutrition_facts_card.dart`
- `lib/widgets/nutrition/health_score_badge.dart`
- `lib/widgets/nutrition/vitamins_grid.dart`
- `lib/widgets/nutrition/minerals_grid.dart`
- `lib/services/health_score_calculator.dart`

**Subagents to Use:**
- `@uiux-designer` - UI design
- `@flutter-expert` - Widget implementation
- `@nutrition-data-expert` - Health score algorithm

### 📊 Phase 3: Dashboard (Week 5-6)
**Mục tiêu:** Daily nutrition tracking & dashboard

**Tasks:**
1. ⬜ Design `NutritionDashboardScreen`
2. ⬜ Create daily nutrition calculator
3. ⬜ Implement macro tracking (protein, carbs, fat)
4. ⬜ Implement micro tracking (vitamins, minerals)
5. ⬜ Add charts with `fl_chart` package
6. ⬜ Create RDA progress indicators
7. ⬜ Add nutrition goals setting
8. ⬜ Implement food waste analytics

**Estimated Time:** 15-20 hours

**Dependencies:**
```yaml
dependencies:
  fl_chart: ^0.65.0  # Charts
  intl: ^0.18.1      # Already have
```

**Files to Create:**
- `lib/screens/nutrition_dashboard_screen.dart`
- `lib/widgets/charts/macro_chart.dart`
- `lib/widgets/charts/vitamin_chart.dart`
- `lib/services/daily_nutrition_calculator.dart`
- `lib/providers/nutrition_provider.dart`

**Subagents to Use:**
- `@uiux-designer` - Dashboard design
- `@flutter-expert` - Chart implementation
- `@nutrition-data-expert` - Calculations

### 🧠 Phase 4: Intelligence (Week 7-8)
**Mục tiêu:** Smart recommendations & meal planning

**Tasks:**
1. ⬜ Implement recommendation engine
2. ⬜ Create `RecommendationsScreen`
3. ⬜ Build shopping list feature
4. ⬜ Integrate recipe API (Optional)
5. ⬜ Create meal planner
6. ⬜ Add diet mode filters
7. ⬜ Add allergen warnings
8. ⬜ Implement food substitution suggestions

**Estimated Time:** 20-25 hours

**Files to Create:**
- `lib/services/recommendation_engine.dart`
- `lib/screens/recommendations_screen.dart`
- `lib/screens/shopping_list_screen.dart`
- `lib/screens/meal_planner_screen.dart`
- `lib/services/edamam_recipe_service.dart` (Optional)

**Subagents to Use:**
- `@product-manager` - Feature prioritization
- `@nutrition-data-expert` - Recommendation logic
- `@flutter-expert` - Implementation

### ✨ Phase 5: Polish (Week 9-10)
**Mục tiêu:** UI/UX refinement, testing, optimization

**Tasks:**
1. ⬜ UI/UX review with `@uiux-designer`
2. ⬜ Performance optimization
3. ⬜ Write unit tests
4. ⬜ Write widget tests
5. ⬜ User testing
6. ⬜ Bug fixes
7. ⬜ Documentation
8. ⬜ App store preparation

**Estimated Time:** 15-20 hours

---

## 💰 CHI PHÍ DỰ TÍNH

### APIs
| Service | Free Tier | Cost |
|---------|-----------|------|
| USDA FoodData Central | Unlimited | **$0** ✅ |
| Open Food Facts | Unlimited | **$0** ✅ |
| Edamam Recipe (Optional) | 10K/month | **$0** ✅ |

### Hosting/Database
| Service | Usage | Cost |
|---------|-------|------|
| Local SQLite | Offline-first | **$0** ✅ |
| Flutter app | Native mobile | **$0** ✅ |

### Development Time
| Phase | Hours | @ $30/hr |
|-------|-------|----------|
| Phase 1 | 15 | $450 |
| Phase 2 | 20 | $600 |
| Phase 3 | 20 | $600 |
| Phase 4 | 25 | $750 |
| Phase 5 | 20 | $600 |
| **Total** | **100 hrs** | **$3,000** |

*Note: Nếu tự code thì chỉ mất thời gian, không mất tiền*

**TOTAL COST: $0 API + $0 Hosting = $0** 🎉

---

## 🎯 CÁCH SỬ DỤNG SUBAGENTS

### Example Workflow

#### 1. Khi Cần Thiết Kế UI

```bash
# Trong chat với Claude
@uiux-designer

Tôi cần thiết kế màn hình "Nutrition Dashboard" với các yêu cầu:

Context:
- App dành cho phụ nữ
- Design system: Feminine, pastel colors, rounded
- Colors: Rose Quartz (#FFD6E8), Lavender (#E8D5F2)

Cần hiển thị:
1. Daily calorie progress (circular chart)
2. Macro breakdown (pie chart: protein, carbs, fat)
3. Top 5 vitamins progress bars
4. Suggestions card

Tham khảo design hiện tại:
- [Mô tả homescreen hiện tại]

Hãy design layout, components, spacing
```

#### 2. Khi Cần Tích Hợp API

```bash
@nutrition-data-expert

Giúp tôi integrate USDA FoodData Central API vào Flutter app.

Current setup:
- Flutter 3.8.1
- Using http package
- Need to search foods and get nutrition facts

Tasks:
1. Create USDAApiService singleton class
2. Implement searchFoods(query) method
3. Implement getNutritionFacts(fdcId) method
4. Handle errors and caching
5. Parse JSON response to NutritionFacts model

Provide complete, production-ready code.
```

#### 3. Khi Cần Implement Widget

```bash
@flutter-expert

Implement NutritionFactsCard widget với specs:

Design:
- Gradient card (snow white → pearl gray)
- Rounded corners (16px)
- Soft shadow
- Nutrition label style (FDA format)

Data to display:
- Calories (large, center)
- Macros (protein, carbs, fat) with bars
- Serving size
- Top 5 vitamins với % RDA

State:
- Takes NutritionFacts object
- Animated progress bars

Provide complete widget code với V2 design system.
```

### Parallel Agents (Làm Nhiều Task Cùng Lúc)

```bash
# Design UI
@uiux-designer: Design nutrition dashboard layout

# While waiting, prepare data layer
@nutrition-data-expert: Write health score algorithm

# And prepare Flutter structure
@flutter-expert: Create nutrition feature folder structure
```

---

## 📚 TÀI LIỆU THAM KHẢO

### APIs
- [USDA FoodData Central API](https://fdc.nal.usda.gov/api-guide.html)
- [Open Food Facts API](https://world.openfoodfacts.org/data)
- [Edamam Recipe API](https://developer.edamam.com/)

### Nutrition Science
- [FDA Nutrition Facts Label](https://www.fda.gov/food/nutrition-facts-label)
- [WHO Nutrition Guidelines](https://www.who.int/nutrition)
- [USDA Dietary Guidelines](https://www.dietaryguidelines.gov/)

### Flutter Packages
- [fl_chart](https://pub.dev/packages/fl_chart) - Beautiful charts
- [provider](https://pub.dev/packages/provider) - State management
- [sqflite](https://pub.dev/packages/sqflite) - SQLite database
- [http](https://pub.dev/packages/http) - HTTP client

---

## ✅ CHECKLIST - BẮT ĐẦU NHƯ THẾ NÀO?

### Bước 1: Setup API (5 phút)
- [ ] Vào https://fdc.nal.usda.gov/api-key-signup.html
- [ ] Đăng ký email
- [ ] Copy API key
- [ ] Test API với curl hoặc Postman

### Bước 2: Đọc Documents (30 phút)
- [ ] Đọc `COMPREHENSIVE_ANALYSIS.md`
- [ ] Đọc `subagents/nutrition-data-expert.md`
- [ ] Đọc `subagents/README.md`

### Bước 3: Plan Implementation (1 giờ)
- [ ] Review database schema
- [ ] Review code examples
- [ ] Quyết định bắt đầu từ Phase nào
- [ ] List ra files cần tạo

### Bước 4: Start Coding (với Subagents)
- [ ] Use `@nutrition-data-expert` cho API integration
- [ ] Use `@flutter-expert` cho widget implementation
- [ ] Use `@uiux-designer` cho UI design
- [ ] Code từng feature nhỏ, test ngay

### Bước 5: Test & Iterate
- [ ] Test mỗi feature sau khi code xong
- [ ] Get feedback từ users
- [ ] Iterate và improve

---

## 🎓 TIPS & BEST PRACTICES

### Development Tips

1. **Start Small**
   - Implement nutrition facts display first
   - Then add health score
   - Then tracking
   - Then recommendations

2. **Use Subagents Effectively**
   - Ask specific questions
   - Provide context
   - Reference existing code
   - Request complete, production-ready code

3. **Cache Everything**
   - Cache API responses (24 hours)
   - Cache calculated health scores
   - Cache user nutrition data

4. **Offline-First**
   - App phải work without internet
   - Sync khi có internet
   - Show cached data

5. **Performance**
   - Use `const` constructors
   - Lazy load data
   - Optimize images
   - Profile regularly

### UI/UX Tips

1. **Keep It Simple**
   - Don't overwhelm user với too much data
   - Progressive disclosure
   - Focus on actionable insights

2. **Visual Hierarchy**
   - Health score = Most prominent
   - Macros = Secondary
   - Micros = Tertiary

3. **Colors = Meaning**
   - Green = Good, healthy
   - Yellow = Moderate
   - Red = Warning, limit

4. **Feedback**
   - Show loading states
   - Show success/error messages
   - Provide context for numbers

---

## 🚀 READY TO START?

### Quick Start Commands

```bash
# 1. Create new branch
git checkout -b feature/nutrition-tracking

# 2. Install dependencies (if needed)
flutter pub add fl_chart

# 3. Start with Phase 1
# Use @nutrition-data-expert để integrate USDA API

# 4. Commit frequently
git add .
git commit -m "feat: Add USDA API service"

# 5. Test on device
flutter run
```

### First Task (Recommended)

**Task:** Setup USDA API Integration

**Prompt to Use:**
```
@nutrition-data-expert

Help me integrate USDA FoodData Central API.

My API key: [YOUR_KEY]

Create:
1. lib/services/usda_api_service.dart
2. Test searchFoods("tomato")
3. Test getNutritionFacts(fdcId)

Provide complete, production-ready Flutter code.
```

**Expected Time:** 1-2 hours

**Success Criteria:**
- ✅ API calls work
- ✅ JSON parsing works
- ✅ Error handling works
- ✅ Can search and get nutrition data

---

## 📞 CẦN HỖ TRỢ?

### Khi Gặp Vấn Đề

1. **API không work?**
   - Check API key có đúng không
   - Check network connection
   - Use `@nutrition-data-expert` để debug

2. **UI không đẹp?**
   - Reference V2 design system
   - Use `@uiux-designer` để improve
   - Check existing widgets for consistency

3. **Performance issues?**
   - Use `@flutter-expert` để optimize
   - Profile with DevTools
   - Check database queries

4. **Database errors?**
   - Check migration scripts
   - Use `@backend-architect` cho database design
   - Test queries trên SQLite browser

---

## 🎯 SUCCESS METRICS

### How to Know You're Done

#### Phase 1: Foundation
- ✅ USDA API working
- ✅ Database tables created
- ✅ Can fetch and store nutrition data

#### Phase 2: Core UI
- ✅ Nutrition facts display beautifully
- ✅ Health score badge shows correctly
- ✅ Vitamins/minerals grid works

#### Phase 3: Dashboard
- ✅ Daily tracking works
- ✅ Charts display correctly
- ✅ RDA calculations accurate

#### Phase 4: Intelligence
- ✅ Recommendations make sense
- ✅ Shopping list helpful
- ✅ Diet filters work

#### Phase 5: Polish
- ✅ No bugs
- ✅ Smooth performance
- ✅ Beautiful UI
- ✅ Great UX

### User Feedback Goals

- ⭐️ "Wow, tính năng này hữu ích quá!"
- ⭐️ "Giờ tôi biết mình đang ăn gì rồi"
- ⭐️ "App này giúp tôi healthy hơn"
- ⭐️ "Thiết kế đẹp và dễ dùng"

---

**🎉 Chúc bạn thành công với dự án! Happy coding! 🚀**

---

*Created with ❤️ by Claude*
*Last updated: 2025-01-11*
