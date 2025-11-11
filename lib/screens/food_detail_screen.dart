import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/category.dart';
import '../models/nutrition_facts.dart';
import '../providers/food_provider.dart';
import '../database/database_helper.dart';
import '../utils/date_utils.dart';
import '../widgets/expiry_badge.dart';
import '../widgets/nutrition_facts_card.dart';
import 'add_food_screen.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  NutritionFacts? _nutritionFacts;
  bool _isLoadingNutrition = true;

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    if (widget.food.id != null) {
      try {
        final nutritionData = await DatabaseHelper.instance.getNutritionFacts(widget.food.id!);
        if (nutritionData != null && mounted) {
          setState(() {
            _nutritionFacts = NutritionFacts.fromMap(nutritionData);
            _isLoadingNutrition = false;
          });
        } else if (mounted) {
          setState(() => _isLoadingNutrition = false);
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoadingNutrition = false);
        }
      }
    } else {
      setState(() => _isLoadingNutrition = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = FoodCategory.getById(widget.food.category);
    final location = StorageLocation.getById(widget.food.storageLocation);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết thực phẩm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AddFoodScreen(food: widget.food),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Image
          if (widget.food.imagePath != null && File(widget.food.imagePath!).existsSync())
            Image.file(
              File(widget.food.imagePath!),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          else
            Container(
              height: 200,
              color: category.color.withOpacity(0.2),
              child: Icon(
                category.icon,
                size: 100,
                color: category.color,
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  widget.food.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Expiry Badge
                LargeExpiryBadge(food: widget.food),
                const SizedBox(height: 24),

                // Details
                _buildDetailRow(
                  Icons.category,
                  'Danh mục',
                  category.name,
                  category.color,
                ),
                const Divider(),

                _buildDetailRow(
                  Icons.location_on,
                  'Vị trí lưu trữ',
                  location.name,
                ),
                const Divider(),

                _buildDetailRow(
                  Icons.shopping_cart,
                  'Số lượng',
                  '${widget.food.quantity} ${widget.food.unit}',
                ),
                const Divider(),

                _buildDetailRow(
                  Icons.shopping_bag,
                  'Ngày mua',
                  AppDateUtils.formatDate(widget.food.purchaseDate),
                ),
                const Divider(),

                _buildDetailRow(
                  Icons.event_busy,
                  'Hạn sử dụng',
                  AppDateUtils.formatDate(widget.food.expiryDate),
                ),
                const Divider(),

                if (widget.food.barcode != null) ...[
                  _buildDetailRow(
                    Icons.qr_code,
                    'Mã vạch',
                    widget.food.barcode!,
                  ),
                  const Divider(),
                ],

                if (widget.food.notes != null && widget.food.notes!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Ghi chú',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.food.notes!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],

                // Nutrition Facts Section
                const SizedBox(height: 24),
                if (_isLoadingNutrition)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_nutritionFacts != null) ...[
                  const Text(
                    'Thông tin dinh dưỡng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  NutritionFactsCard(
                    nutritionFacts: _nutritionFacts!,
                    isCompact: false,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, [
    Color? iconColor,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa "${widget.food.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<FoodProvider>().deleteFood(widget.food);
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close detail screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã xóa thực phẩm')),
                );
              }
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
