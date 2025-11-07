# Fridge Tracker - Implementation Guide Part 2
## Screens & Advanced Components

---

## PHASE 4: UPDATE FOOD CARD (Days 11-12)

### Step 4.1: Create Enhanced Food Card

**File:** `d:\fridge_tracker\lib\widgets\food_card.dart` (REPLACE ENTIRE FILE)

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/food_item.dart';
import '../models/category.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';
import '../utils/app_spacing.dart';
import '../utils/app_shadows.dart';
import '../utils/date_utils.dart';
import 'expiry_badge.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final category = FoodCategory.getById(food.category);
    final location = StorageLocation.getById(food.storageLocation);

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: AppColors.primaryLavender,
            foregroundColor: Colors.white,
            icon: Icons.edit_rounded,
            label: 'Sửa',
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(BorderRadii.lg),
              bottomLeft: Radius.circular(BorderRadii.lg),
            ),
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: AppColors.expiredPrimary,
            foregroundColor: Colors.white,
            icon: Icons.delete_rounded,
            label: 'Xóa',
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(BorderRadii.lg),
              bottomRight: Radius.circular(BorderRadii.lg),
            ),
          ),
        ],
      ),
      child: _buildCard(category, location),
    );
  }

  Widget _buildCard(FoodCategory category, StorageLocation location) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(BorderRadii.lg),
        boxShadow: AppShadows.soft,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(BorderRadii.lg),
          child: Padding(
            padding: const EdgeInsets.all(Spacing.sm),
            child: Row(
              children: [
                // Image with badge overlay
                _buildThumbnail(category),
                const SizedBox(width: Spacing.sm),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        food.name,
                        style: AppTypography.h4.copyWith(
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Spacing.xxs + 2),

                      // Category & Location
                      _buildInfoRow(category, location),
                      const SizedBox(height: Spacing.xs),

                      // Expiry date & badge
                      _buildExpiryRow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(FoodCategory category) {
    return Stack(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BorderRadii.md),
            gradient: LinearGradient(
              colors: [
                AppColors.primaryPink.withOpacity(0.15),
                AppColors.primaryLavender.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(BorderRadii.md),
            child: food.imagePath != null && File(food.imagePath!).existsSync()
                ? Image.file(
                    File(food.imagePath!),
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Icon(
                      category.icon,
                      size: 36,
                      color: category.color,
                    ),
                  ),
          ),
        ),

        // Priority badge for expiring soon items
        if (food.expiryStatus == ExpiryStatus.expiringSoon)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.warnGradient,
                shape: BoxShape.circle,
                boxShadow: AppShadows.coloredShadow(
                  AppColors.warnPrimary,
                  opacity: 0.4,
                ),
              ),
              child: const Center(
                child: Text(
                  '⚡',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(FoodCategory category, StorageLocation location) {
    return Row(
      children: [
        // Category
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.xs,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(BorderRadii.xs),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                category.icon,
                size: 12,
                color: category.color,
              ),
              const SizedBox(width: Spacing.xxs),
              Text(
                category.name,
                style: AppTypography.labelSmall.copyWith(
                  color: category.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.xs),

        // Location
        Icon(
          location.icon,
          size: 12,
          color: AppColors.textLight,
        ),
        const SizedBox(width: Spacing.xxs),
        Text(
          location.name,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryRow() {
    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 12,
          color: AppColors.textLight,
        ),
        const SizedBox(width: Spacing.xxs),
        Text(
          'HSD: ${AppDateUtils.formatDate(food.expiryDate)}',
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textLight,
          ),
        ),
        const Spacer(),
        ExpiryBadge(food: food),
      ],
    );
  }
}
```

---

## PHASE 5: UPDATE HOME SCREEN (Days 13-15)

### Step 5.1: Create Gradient AppBar Widget

**File:** `d:\fridge_tracker\lib\widgets\cute/gradient_app_bar.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double elevation;

  const GradientAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    this.elevation = 0,
  });

  @override
  Size get preferredSize {
    double height = kToolbarHeight;
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(BorderRadii.sm),
              ),
              child: const Center(
                child: Text(
                  '🧊',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Text(
              title,
              style: AppTypography.h2.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: elevation,
        actions: actions,
        bottom: bottom,
      ),
    );
  }
}
```

### Step 5.2: Create Search Bar Widget

**File:** `d:\fridge_tracker\lib\widgets\cute\cute_search_bar.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_shadows.dart';

class CuteSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final VoidCallback? onClear;
  final String hintText;

  const CuteSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = 'Tìm kiếm...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.soft,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTypography.bodyMedium,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textLight,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.primaryPink,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: AppColors.textLight,
                  ),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Spacing.sm,
          ),
        ),
      ),
    );
  }
}
```

### Step 5.3: Create Category Filter Widget

**File:** `d:\fridge_tracker\lib\widgets\category_filter.dart` (UPDATE)

```dart
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';
import '../utils/app_spacing.dart';
import '../utils/app_shadows.dart';

class CategoryFilter extends StatelessWidget {
  final String? selectedCategory;
  final void Function(String?) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.sm,
          vertical: Spacing.xs,
        ),
        children: [
          _buildChip(
            label: 'Tất cả',
            icon: Icons.apps_rounded,
            color: AppColors.primaryPink,
            isSelected: selectedCategory == null,
            onTap: () => onCategorySelected(null),
          ),
          ...FoodCategory.defaultCategories.map((category) {
            return _buildChip(
              label: category.name,
              icon: category.icon,
              color: category.color,
              isSelected: selectedCategory == category.id,
              onTap: () => onCategorySelected(category.id),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.xxs),
      child: Material(
        color: isSelected ? color : Colors.white,
        borderRadius: BorderRadius.circular(BorderRadii.lg),
        elevation: isSelected ? 2 : 0,
        shadowColor: color.withOpacity(0.3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(BorderRadii.lg),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md,
              vertical: Spacing.xs,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.transparent : AppColors.mediumGray,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(BorderRadii.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? Colors.white : color,
                ),
                const SizedBox(width: Spacing.xxs + 2),
                Text(
                  label,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
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

### Step 5.4: Update Home Screen

**File:** `d:\fridge_tracker\lib\screens\home_screen.dart` (UPDATE)

Key changes to make:
1. Import new widgets
2. Replace AppBar with GradientAppBar
3. Update search bar styling
4. Update tab bar with cute styling
5. Add entry animations

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/food_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/food_card.dart';
import '../widgets/category_filter.dart';
import '../widgets/empty_state.dart';
import '../widgets/cute/gradient_app_bar.dart';
import '../widgets/cute/cute_search_bar.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';
import '../utils/app_spacing.dart';
import 'add_food_screen.dart';
import 'food_detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodProvider>().loadFoods();
    });
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final provider = context.read<FoodProvider>();
      switch (_tabController.index) {
        case 0:
          provider.filterByStatus(FoodFilter.all);
          break;
        case 1:
          provider.filterByStatus(FoodFilter.fresh);
          break;
        case 2:
          provider.filterByStatus(FoodFilter.expiringSoon);
          break;
        case 3:
          provider.filterByStatus(FoodFilter.expired);
          break;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Tủ Lạnh Của Tôi',
        actions: [
          Container(
            margin: const EdgeInsets.only(right: Spacing.xs),
            child: Material(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(BorderRadii.sm),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(BorderRadii.sm),
                child: Container(
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.settings_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              // Search bar
              CuteSearchBar(
                controller: _searchController,
                hintText: 'Tìm kiếm thực phẩm...',
                onChanged: (value) {
                  context.read<FoodProvider>().search(value);
                },
                onClear: () {
                  _searchController.clear();
                  context.read<FoodProvider>().search('');
                },
              ),

              // Tab bar
              _buildTabBar(),
            ],
          ),
        ),
      ),
      body: Consumer<FoodProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return _buildLoading();
          }

          return Column(
            children: [
              // Category filter
              CategoryFilter(
                selectedCategory: provider.selectedCategory,
                onCategorySelected: (category) {
                  provider.filterByCategory(category);
                },
              ),
              const Divider(height: 1),

              // Food list
              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.refresh,
                  color: AppColors.primaryPink,
                  child: provider.foods.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          itemCount: provider.foods.length,
                          itemBuilder: (context, index) {
                            final food = provider.foods[index];
                            return FoodCard(
                              food: food,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FoodDetailScreen(food: food),
                                  ),
                                ).then((_) => provider.loadFoods());
                              },
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddFoodScreen(food: food),
                                  ),
                                ).then((_) => provider.loadFoods());
                              },
                              onDelete: () {
                                _showDeleteDialog(context, food);
                              },
                            )
                                .animate()
                                .fadeIn(
                                  duration: 300.ms,
                                  delay: (50 * index).ms,
                                )
                                .slideY(
                                  begin: 0.2,
                                  end: 0,
                                  curve: Curves.easeOut,
                                );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        tabs: [
          _buildTab('Tất cả', FoodFilter.all),
          _buildTab('Còn hạn', FoodFilter.fresh),
          _buildTab('Sắp hết', FoodFilter.expiringSoon),
          _buildTab('Hết hạn', FoodFilter.expired),
        ],
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(
            width: 3,
            color: AppColors.primaryPink,
          ),
          insets: const EdgeInsets.symmetric(horizontal: Spacing.md),
        ),
        labelColor: AppColors.primaryPink,
        unselectedLabelColor: AppColors.textLight,
        labelStyle: AppTypography.labelLarge,
        unselectedLabelStyle: AppTypography.labelMedium,
      ),
    );
  }

  Widget _buildTab(String label, FoodFilter filter) {
    return Consumer<FoodProvider>(
      builder: (_, provider, __) {
        int count;
        Color color;

        switch (filter) {
          case FoodFilter.all:
            count = provider.totalFoods;
            color = AppColors.textDark;
            break;
          case FoodFilter.fresh:
            count = provider.freshCount;
            color = AppColors.freshPrimary;
            break;
          case FoodFilter.expiringSoon:
            count = provider.expiringSoonCount;
            color = AppColors.warnPrimary;
            break;
          case FoodFilter.expired:
            count = provider.expiredCount;
            color = AppColors.expiredPrimary;
            break;
        }

        return Tab(
          height: 64,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              const SizedBox(height: Spacing.xxs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.xs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(BorderRadii.xs),
                ),
                child: Text(
                  '$count',
                  style: AppTypography.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primaryPink,
          ),
          const SizedBox(height: Spacing.md),
          Text(
            'Đang tải...',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final currentFilter = context.read<FoodProvider>().currentFilter;

    String title;
    String message;
    String emoji;

    switch (currentFilter) {
      case FoodFilter.expired:
        title = 'Không có thực phẩm hết hạn';
        message = 'Tuyệt vời! Tủ lạnh của bạn đang được quản lý tốt. 🎉';
        emoji = '✅';
        break;
      case FoodFilter.expiringSoon:
        title = 'Không có thực phẩm sắp hết hạn';
        message = 'Tất cả thực phẩm đều còn hạn sử dụng tốt. ✨';
        emoji = '⏰';
        break;
      case FoodFilter.fresh:
        title = 'Không có thực phẩm mới';
        message = 'Hãy kiểm tra tủ lạnh và thêm thực phẩm vào danh sách. 📝';
        emoji = '🧊';
        break;
      default:
        title = 'Tủ lạnh trống trơn';
        message =
            'Hãy thêm thực phẩm đầu tiên của bạn để bắt đầu quản lý tủ lạnh nhé! 💕';
        emoji = '🧊';
    }

    return EmptyState(
      icon: emoji,
      title: title,
      message: message,
      actionLabel: currentFilter == FoodFilter.all ? 'Thêm thực phẩm' : null,
      onAction: currentFilter == FoodFilter.all
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFoodScreen()),
              ).then((_) => context.read<FoodProvider>().loadFoods());
            }
          : null,
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddFoodScreen()),
            ).then((_) => context.read<FoodProvider>().loadFoods());
          },
          borderRadius: BorderRadius.circular(28),
          child: const Center(
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.lg),
        ),
        title: Row(
          children: [
            const Text('⚠️'),
            const SizedBox(width: Spacing.xs),
            Text(
              'Xác nhận xóa',
              style: AppTypography.h3,
            ),
          ],
        ),
        content: Text(
          'Bạn có chắc muốn xóa "${food.name}"?',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Hủy',
              style: AppTypography.button.copyWith(
                color: AppColors.textLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<FoodProvider>().deleteFood(food);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Đã xóa thực phẩm'),
                  backgroundColor: AppColors.expiredPrimary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BorderRadii.sm),
                  ),
                ),
              );
            },
            child: Text(
              'Xóa',
              style: AppTypography.button.copyWith(
                color: AppColors.expiredPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## PHASE 6: UPDATE EMPTY STATE (Day 16)

**File:** `d:\fridge_tracker\lib\widgets\empty_state.dart` (UPDATE)

```dart
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';
import '../utils/app_spacing.dart';
import '../widgets/cute/cute_button.dart';

class EmptyState extends StatelessWidget {
  final String icon; // Emoji
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryPink.withOpacity(0.1),
                    AppColors.primaryLavender.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Title
            Text(
              title,
              style: AppTypography.h1.copyWith(
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.sm),

            // Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
              child: Text(
                message,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textLight,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Action button
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: Spacing.xl),
              CuteButton(
                label: actionLabel!,
                icon: Icons.add_circle_outline_rounded,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## TESTING AFTER PHASE 5

Run the app and test:
- [ ] Gradient header looks good
- [ ] Search bar works smoothly
- [ ] Tabs switch correctly
- [ ] Category filter scrolls horizontally
- [ ] Food cards look cute
- [ ] Swipe to edit/delete works
- [ ] Empty states show correctly
- [ ] FAB gradient and shadow look good
- [ ] Animations are smooth
- [ ] No performance issues

---

## CONTINUE TO PART 3

Next parts will cover:
- Add/Edit Food Screen redesign
- Food Detail Screen redesign
- Settings Screen redesign
- Final polish and animations
- Achievement system (optional)

Save your work and commit:
```bash
git add .
git commit -m "feat: redesign home screen with cute UI"
```
