import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';
import '../models/category.dart';
import '../models/product_info.dart';
import '../providers/food_provider.dart';
import '../providers/settings_provider.dart';
import '../services/barcode_service.dart';
import '../services/image_service.dart';
import '../utils/constants.dart';
import '../utils/app_colors_v2.dart';
import '../utils/app_typography_v2.dart';
import '../utils/app_spacing_v2.dart';
import '../utils/app_shadows_v2.dart';
import '../widgets/cute/cute_button_v2.dart';
import '../widgets/cute/cute_input_field_v2.dart';

class AddFoodScreen extends StatefulWidget {
  final FoodItem? food;

  const AddFoodScreen({super.key, this.food});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();

  String _selectedCategory = FoodCategory.defaultCategories.first.id;
  String _selectedLocation = StorageLocation.defaultLocations.first.id;
  String _selectedUnit = AppConstants.units.first;
  DateTime _purchaseDate = DateTime.now();
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 7));
  String? _imagePath;
  String? _barcode;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      _isEditing = true;
      final food = widget.food!;
      _nameController.text = food.name;
      _selectedCategory = food.category;
      _selectedLocation = food.storageLocation;
      _purchaseDate = food.purchaseDate;
      _expiryDate = food.expiryDate;
      _quantityController.text = food.quantity.toString();
      _selectedUnit = food.unit;
      _notesController.text = food.notes ?? '';
      _imagePath = food.imagePath;
      _barcode = food.barcode;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsV2.snowWhite,
      appBar: AppBar(
        backgroundColor: AppColorsV2.snowWhite,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(AppSpacingV2.s),
          decoration: BoxDecoration(
            color: AppColorsV2.pearlGray.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: AppShadowsV2.subtle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColorsV2.roseQuartz,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacingV2.s),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColorsV2.gradientPrimary,
                ),
                borderRadius: AppSpacingV2.borderM,
                boxShadow: AppShadowsV2.soft,
              ),
              child: Text(
                _isEditing ? '✏️' : '✨',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            AppSpacingV2.hGapM,
            Text(
              _isEditing ? 'Sửa thực phẩm' : 'Thêm thực phẩm',
              style: AppTypographyV2.titleLarge(
                color: AppColorsV2.charcoalSoft,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacingV2.m),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _saveFood,
                borderRadius: AppSpacingV2.borderFull,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColorsV2.gradientPrimary,
                    ),
                    borderRadius: AppSpacingV2.borderFull,
                    boxShadow: AppShadowsV2.medium,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingV2.l,
                    vertical: AppSpacingV2.m,
                  ),
                  child: Row(
                    children: [
                      const Text('💾', style: TextStyle(fontSize: 16)),
                      AppSpacingV2.hGapXs,
                      Text(
                        'Lưu',
                        style: AppTypographyV2.labelMedium(
                          color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(AppSpacingV2.l),
          children: [
            // Image
            _buildImageSection(),
            AppSpacingV2.gapXl,

            // Name - Using CuteInputFieldV2
            CuteInputFieldV2(
              controller: _nameController,
              labelText: 'Tên thực phẩm',
              hintText: 'VD: Cà chua bi',
              emoji: '🍎',
              icon: Icons.inventory_2_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên thực phẩm';
                }
                return null;
              },
            ),
            AppSpacingV2.gapL,

            // Category
            Container(
              decoration: BoxDecoration(
                color: AppColorsV2.snowWhite,
                borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                boxShadow: AppShadowsV2.neuEmbossed, // Raised effect for dropdowns
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacingV2.m),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                style: AppTypographyV2.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Danh mục',
                  labelStyle: AppTypographyV2.bodyMedium.copyWith(
                    color: AppColorsV2.textLight,
                  ),
                  prefixIcon: const Text('🏷️', style: TextStyle(fontSize: 20)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacingV2.m),
                ),
                items: FoodCategory.defaultCategories.map((cat) {
                  return DropdownMenuItem(
                    value: cat.id,
                    child: Row(
                      children: [
                        Icon(cat.icon, size: 20, color: cat.color),
                        const SizedBox(width: 8),
                        Text(cat.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedCategory = value);
                },
              ),
            ),
            const SizedBox(height: AppSpacingV2.m),

            // Storage Location
            Container(
              decoration: BoxDecoration(
                color: AppColorsV2.snowWhite,
                borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                boxShadow: AppShadowsV2.neuEmbossed,
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacingV2.m),
              child: DropdownButtonFormField<String>(
                value: _selectedLocation,
                style: AppTypographyV2.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Vị trí lưu trữ',
                  labelStyle: AppTypographyV2.bodyMedium.copyWith(
                    color: AppColorsV2.textLight,
                  ),
                  prefixIcon: const Text('📍', style: TextStyle(fontSize: 20)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacingV2.m),
                ),
                items: StorageLocation.defaultLocations.map((loc) {
                  return DropdownMenuItem(
                    value: loc.id,
                    child: Row(
                      children: [
                        Icon(loc.icon, size: 20),
                        const SizedBox(width: 8),
                        Text(loc.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedLocation = value);
                },
              ),
            ),
            const SizedBox(height: AppSpacingV2.m),

            // Quantity and Unit
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColorsV2.snowWhite,
                      borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                      boxShadow: AppShadowsV2.neuDebossed,
                    ),
                    child: TextFormField(
                      controller: _quantityController,
                      style: AppTypographyV2.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'Số lượng',
                        labelStyle: AppTypographyV2.bodyMedium.copyWith(
                          color: AppColorsV2.textLight,
                        ),
                        prefixIcon: const Text('🔢', style: TextStyle(fontSize: 20)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacingV2.m,
                          vertical: AppSpacingV2.m,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập số lượng';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Số không hợp lệ';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacingV2.m),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColorsV2.snowWhite,
                      borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                      boxShadow: AppShadowsV2.neuEmbossed,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacingV2.s),
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      style: AppTypographyV2.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'Đơn vị',
                        labelStyle: AppTypographyV2.bodyMedium.copyWith(
                          color: AppColorsV2.textLight,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: AppSpacingV2.m),
                      ),
                      items: AppConstants.units.map((unit) {
                        return DropdownMenuItem(value: unit, child: Text(unit));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _selectedUnit = value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacingV2.m),

            // Purchase Date
            Container(
              decoration: BoxDecoration(
                color: AppColorsV2.snowWhite,
                borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                boxShadow: AppShadowsV2.neuEmbossed,
              ),
              child: ListTile(
                leading: const Text('🛒', style: TextStyle(fontSize: 24)),
                title: Text('Ngày mua', style: AppTypographyV2.bodyMedium),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(_purchaseDate),
                  style: AppTypographyV2.bodySmall.copyWith(color: AppColorsV2.textLight),
                ),
                trailing: const Icon(Icons.calendar_today, color: AppColorsV2.primaryPink),
                onTap: () => _selectDate(context, true),
              ),
            ),
            const SizedBox(height: AppSpacingV2.m),

            // Expiry Date
            Container(
              decoration: BoxDecoration(
                color: AppColorsV2.snowWhite,
                borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                boxShadow: AppShadowsV2.neuEmbossed,
              ),
              child: ListTile(
                leading: const Text('⏰', style: TextStyle(fontSize: 24)),
                title: Text('Hạn sử dụng', style: AppTypographyV2.bodyMedium),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(_expiryDate),
                  style: AppTypographyV2.bodySmall.copyWith(color: AppColorsV2.textLight),
                ),
                trailing: const Icon(Icons.calendar_today, color: AppColorsV2.primaryPink),
                onTap: () => _selectDate(context, false),
              ),
            ),
            const SizedBox(height: AppSpacingV2.m),

            // Barcode
            Container(
              decoration: BoxDecoration(
                color: AppColorsV2.snowWhite,
                borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                boxShadow: AppShadowsV2.neuEmbossed,
              ),
              child: ListTile(
                leading: const Text('📱', style: TextStyle(fontSize: 24)),
                title: Text(
                  _barcode ?? 'Quét mã vạch',
                  style: AppTypographyV2.bodyMedium,
                ),
                trailing: const Icon(Icons.qr_code_scanner, color: AppColorsV2.primaryPink),
                onTap: _scanBarcode,
              ),
            ),

            const SizedBox(height: AppSpacingV2.m),

            // Notes
            Container(
              decoration: BoxDecoration(
                color: AppColorsV2.snowWhite,
                borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                boxShadow: AppShadowsV2.neuDebossed,
              ),
              child: TextFormField(
                controller: _notesController,
                style: AppTypographyV2.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Ghi chú',
                  labelStyle: AppTypographyV2.bodyMedium.copyWith(
                    color: AppColorsV2.textLight,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text('📝', style: TextStyle(fontSize: 20)),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacingV2.m,
                    vertical: AppSpacingV2.m,
                  ),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: AppSpacingV2.l),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Center(
      child: GestureDetector(
        onTap: _showImagePicker,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: AppColorsV2.snowWhite,
            borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
            boxShadow: AppShadowsV2.neuEmbossed,
          ),
          child: _imagePath != null && File(_imagePath!).existsSync()
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacingV2.radiusL),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(_imagePath!), fit: BoxFit.cover),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppColorsV2.gradientPrimary,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: AppShadowsV2.neuStrong,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 20),
                            onPressed: () => setState(() => _imagePath = null),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacingV2.m),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColorsV2.gradientPrimary,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: AppShadowsV2.neuStrong,
                      ),
                      child: const Icon(Icons.add_a_photo, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: AppSpacingV2.s),
                    Text(
                      'Thêm ảnh 📸',
                      style: AppTypographyV2.bodyMedium.copyWith(
                        color: AppColorsV2.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColorsV2.snowWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSpacingV2.radiusL),
            topRight: Radius.circular(AppSpacingV2.radiusL),
          ),
          boxShadow: AppShadowsV2.neuStrong,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacingV2.s),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColorsV2.textLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacingV2.m),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColorsV2.gradientPrimary,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: AppShadowsV2.neuSoft,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                ),
                title: Text('Chụp ảnh 📷', style: AppTypographyV2.bodyMedium),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImageService.instance.pickImageFromCamera();
                  if (image != null) {
                    setState(() => _imagePath = image.path);
                  }
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColorsV2.gradientPrimary,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: AppShadowsV2.neuSoft,
                  ),
                  child: const Icon(Icons.photo_library, color: Colors.white, size: 20),
                ),
                title: Text('Chọn từ thư viện 🖼️', style: AppTypographyV2.bodyMedium),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImageService.instance.pickImageFromGallery();
                  if (image != null) {
                    setState(() => _imagePath = image.path);
                  }
                },
              ),
              const SizedBox(height: AppSpacingV2.s),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isPurchaseDate) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isPurchaseDate ? _purchaseDate : _expiryDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        if (isPurchaseDate) {
          _purchaseDate = date;
        } else {
          _expiryDate = date;
        }
      });
    }
  }

  Future<void> _scanBarcode() async {
    final result = await BarcodeService.instance.scanAndGetProductInfo(context);
    final barcode = result['barcode'] as String?;
    final productInfo = result['productInfo'] as ProductInfo?;

    if (barcode != null) {
      setState(() => _barcode = barcode);
    }

    if (productInfo != null) {
      // Tự động điền thông tin từ API
      setState(() {
        // Điền tên sản phẩm nếu chưa có
        if (_nameController.text.isEmpty) {
          _nameController.text = productInfo.displayName;
        }

        // Tự động tính hạn sử dụng
        if (productInfo.expiryDays != null) {
          _expiryDate = _purchaseDate.add(Duration(days: productInfo.expiryDays!));
        }

        // Gợi ý category dựa trên primary category
        _selectedCategory = _mapToFoodCategory(productInfo.primaryCategory);
      });

      // Download và lưu hình ảnh nếu có
      if (productInfo.imageUrl != null && _imagePath == null) {
        _downloadAndSaveImage(productInfo.imageUrl!);
      }

      // Hiển thị thông báo thành công
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã tìm thấy: ${productInfo.displayName}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else if (barcode != null) {
      // Nếu không tìm thấy thông tin nhưng có barcode
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không tìm thấy thông tin sản phẩm. Vui lòng nhập thủ công.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  // Map category từ Open Food Facts sang FoodCategory
  String _mapToFoodCategory(String? category) {
    if (category == null) return _selectedCategory;

    final categoryLower = category.toLowerCase();

    if (categoryLower.contains('vegetable') || categoryLower.contains('produce')) {
      return 'vegetables';
    } else if (categoryLower.contains('fruit')) {
      return 'fruits';
    } else if (categoryLower.contains('meat') ||
               categoryLower.contains('beef') ||
               categoryLower.contains('pork')) {
      return 'meat';
    } else if (categoryLower.contains('fish') || categoryLower.contains('seafood')) {
      return 'seafood';
    } else if (categoryLower.contains('milk') ||
               categoryLower.contains('dairy') ||
               categoryLower.contains('cheese')) {
      return 'dairy';
    } else if (categoryLower.contains('beverage') || categoryLower.contains('drink')) {
      return 'beverages';
    } else if (categoryLower.contains('snack') || categoryLower.contains('dessert')) {
      return 'snacks';
    } else if (categoryLower.contains('frozen')) {
      return 'frozen';
    }

    return _selectedCategory; // Giữ nguyên nếu không match
  }

  // Download và lưu hình ảnh
  Future<void> _downloadAndSaveImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Lưu vào thư mục tạm
        final tempDir = await getTemporaryDirectory();
        final fileName = 'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final filePath = '${tempDir.path}/$fileName';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        setState(() => _imagePath = filePath);
      }
    } catch (e) {
      // Ignore error, user can add image manually
    }
  }

  Future<void> _saveFood() async {
    if (!_formKey.currentState!.validate()) return;

    if (_expiryDate.isBefore(_purchaseDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hạn sử dụng phải sau ngày mua')),
      );
      return;
    }

    final food = FoodItem(
      id: widget.food?.id,
      name: _nameController.text.trim(),
      category: _selectedCategory,
      storageLocation: _selectedLocation,
      purchaseDate: _purchaseDate,
      expiryDate: _expiryDate,
      quantity: double.parse(_quantityController.text),
      unit: _selectedUnit,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      imagePath: _imagePath,
      barcode: _barcode,
    );

    final settings = context.read<SettingsProvider>();
    final foodProvider = context.read<FoodProvider>();

    bool success;
    if (_isEditing) {
      success = await foodProvider.updateFood(food, settings.notifyDaysBefore);
    } else {
      success = await foodProvider.addFood(food, settings.notifyDaysBefore);
    }

    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing ? 'Đã cập nhật thực phẩm' : 'Đã thêm thực phẩm')),
      );
    }
  }
}
