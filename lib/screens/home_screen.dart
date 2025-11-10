import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/food_card_v2.dart';
import '../widgets/category_filter.dart';
import '../widgets/empty_state.dart';
import '../widgets/cute/cute_search_bar_v2.dart';
import '../utils/app_colors_v2.dart';
import '../utils/app_typography_v2.dart';
import '../utils/app_spacing_v2.dart';
import '../utils/app_shadows_v2.dart';
import 'add_food_screen.dart';
import 'food_detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Load foods
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
      backgroundColor: AppColorsV2.snowWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColorsV2.snowWhite,
                AppColorsV2.pearlGray.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppSpacingV2.radiusL),
              bottomRight: Radius.circular(AppSpacingV2.radiusL),
            ),
            boxShadow: AppShadowsV2.soft,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacingV2.l,
                vertical: AppSpacingV2.s,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacingV2.s),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColorsV2.gradientPrimary,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: AppSpacingV2.borderM,
                      boxShadow: AppShadowsV2.soft,
                    ),
                    child: const Text('🧊', style: TextStyle(fontSize: 24)),
                  ),
                  AppSpacingV2.hGapM,
                  Text(
                    'Tủ lạnh của tôi',
                    style: AppTypographyV2.titleLarge(
                      color: AppColorsV2.charcoalSoft,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColorsV2.pearlGray.withOpacity(0.5),
                      shape: BoxShape.circle,
                      boxShadow: AppShadowsV2.subtle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings_rounded,
                        color: AppColorsV2.roseQuartz,
                        size: AppSpacingV2.iconL,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<FoodProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              AppSpacingV2.gapL,
              // Cute Search Bar V2
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacingV2.l),
                child: CuteSearchBarV2(
                  controller: _searchController,
                  hintText: 'Tìm thực phẩm... 🔍',
                  emoji: '🔍',
                  onChanged: (value) {
                    context.read<FoodProvider>().search(value);
                  },
                  onClear: () {
                    _searchController.clear();
                    context.read<FoodProvider>().search('');
                  },
                ),
              ),
              AppSpacingV2.gapM,
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
                  child: provider.foods.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: EdgeInsets.only(
                            top: AppSpacingV2.s,
                            bottom: AppSpacingV2.huge + 60,
                          ),
                          itemCount: provider.foods.length,
                          itemBuilder: (context, index) {
                            final food = provider.foods[index];
                            return FoodCardV2(
                              food: food,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FoodDetailScreen(food: food),
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
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddFoodScreen()),
            );
            if (mounted) {
              context.read<FoodProvider>().loadFoods();
            }
          },
          borderRadius: AppSpacingV2.borderFull,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColorsV2.gradientPrimary,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppSpacingV2.borderFull,
              boxShadow: [
                ...AppShadowsV2.medium,
                ...AppShadowsV2.glowPrimary,
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacingV2.xl,
              vertical: AppSpacingV2.m,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                AppSpacingV2.hGapS,
                Text(
                  'Thêm',
                  style: AppTypographyV2.labelLarge(color: Colors.white),
                ),
                AppSpacingV2.hGapS,
                const Text('✨', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildEmptyState() {
    final currentFilter = context.read<FoodProvider>().currentFilter;

    String title;
    String message;
    IconData icon;

    switch (currentFilter) {
      case FoodFilter.expired:
        title = 'Không có thực phẩm hết hạn';
        message = 'Tuyệt vời! Tủ lạnh của bạn đang được quản lý tốt.';
        icon = Icons.check_circle_outline;
        break;
      case FoodFilter.expiringSoon:
        title = 'Không có thực phẩm sắp hết hạn';
        message = 'Tất cả thực phẩm đều còn hạn sử dụng tốt.';
        icon = Icons.schedule;
        break;
      case FoodFilter.fresh:
        title = 'Không có thực phẩm mới';
        message = 'Hãy kiểm tra tủ lạnh và thêm thực phẩm vào danh sách.';
        icon = Icons.inventory_2;
        break;
      default:
        title = 'Chưa có thực phẩm nào';
        message = 'Hãy thêm thực phẩm đầu tiên của bạn!';
        icon = Icons.shopping_basket;
    }

    return EmptyState(
      icon: icon,
      title: title,
      message: message,
      actionLabel: currentFilter == FoodFilter.all ? 'Thêm thực phẩm' : null,
      onAction: currentFilter == FoodFilter.all
          ? () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFoodScreen()),
              );
              if (mounted) {
                context.read<FoodProvider>().loadFoods();
              }
            }
          : null,
    );
  }

  void _showDeleteDialog(BuildContext context, food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa "${food.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              context.read<FoodProvider>().deleteFood(food);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa thực phẩm')),
              );
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
