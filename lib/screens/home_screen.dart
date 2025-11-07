import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/food_card.dart';
import '../widgets/category_filter.dart';
import '../widgets/empty_state.dart';
import '../widgets/cute/cute_search_bar.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';
import '../utils/app_spacing.dart';
import '../utils/app_shadows.dart';
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
      backgroundColor: AppColors.backgroundNeu,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundNeu,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppSpacing.radiusL),
              bottomRight: Radius.circular(AppSpacing.radiusL),
            ),
            boxShadow: AppShadows.neuEmbossed,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.s,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.gradientUnicorn,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppShadows.neuSoft,
                    ),
                    child: const Text('🦄', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Tủ lạnh của tôi',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundNeu,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.neuEmbossed,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: AppColors.primaryLavender),
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
              const SizedBox(height: AppSpacing.m),
              // Cute Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                child: CuteSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    context.read<FoodProvider>().search(value);
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.m),
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
                          itemCount: provider.foods.length,
                          itemBuilder: (context, index) {
                            final food = provider.foods[index];
                            return FoodCard(
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundNeu,
          borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.radiusFull)),
          boxShadow: AppShadows.neuStrong,
        ),
        child: Material(
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
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.gradientUnicorn,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.radiusFull)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.m,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Thêm thực phẩm',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('🦄', style: TextStyle(fontSize: 18)),
                ],
              ),
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
