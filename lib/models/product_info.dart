// Model cho thông tin sản phẩm từ Open Food Facts API
class ProductInfo {
  final String barcode;
  final String? productName;
  final String? brands;
  final String? imageUrl;
  final String? categories;
  final int? expiryDays; // Số ngày hạn sử dụng trung bình
  final String? quantity;

  ProductInfo({
    required this.barcode,
    this.productName,
    this.brands,
    this.imageUrl,
    this.categories,
    this.expiryDays,
    this.quantity,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    if (product == null) {
      throw Exception('Product not found');
    }

    return ProductInfo(
      barcode: json['code'] as String? ?? '',
      productName: product['product_name'] as String?,
      brands: product['brands'] as String?,
      imageUrl: product['image_url'] as String?,
      categories: product['categories'] as String?,
      quantity: product['quantity'] as String?,
      expiryDays: _estimateExpiryDays(product['categories'] as String?),
    );
  }

  // Ước tính số ngày hạn sử dụng dựa trên category
  static int _estimateExpiryDays(String? categories) {
    if (categories == null) return 7; // Mặc định 7 ngày

    final categoryLower = categories.toLowerCase();

    // Thực phẩm đông lạnh: 90 ngày
    if (categoryLower.contains('frozen') || categoryLower.contains('ice cream')) {
      return 90;
    }

    // Sữa và sản phẩm từ sữa: 7-14 ngày
    if (categoryLower.contains('milk') ||
        categoryLower.contains('dairy') ||
        categoryLower.contains('yogurt') ||
        categoryLower.contains('cheese')) {
      return 10;
    }

    // Thịt tươi: 3-5 ngày
    if (categoryLower.contains('meat') ||
        categoryLower.contains('beef') ||
        categoryLower.contains('pork') ||
        categoryLower.contains('chicken')) {
      return 4;
    }

    // Cá và hải sản: 2-3 ngày
    if (categoryLower.contains('fish') || categoryLower.contains('seafood')) {
      return 2;
    }

    // Rau củ: 7-14 ngày
    if (categoryLower.contains('vegetable') ||
        categoryLower.contains('fruit') ||
        categoryLower.contains('produce')) {
      return 10;
    }

    // Bánh mì: 3-5 ngày
    if (categoryLower.contains('bread') || categoryLower.contains('bakery')) {
      return 4;
    }

    // Đồ uống: 30 ngày
    if (categoryLower.contains('beverage') || categoryLower.contains('drink')) {
      return 30;
    }

    // Thực phẩm khô, đóng hộp: 180 ngày
    if (categoryLower.contains('canned') ||
        categoryLower.contains('dried') ||
        categoryLower.contains('packaged')) {
      return 180;
    }

    // Mặc định: 7 ngày
    return 7;
  }

  // Lấy tên hiển thị (ưu tiên product name, fallback brands)
  String get displayName {
    if (productName != null && productName!.isNotEmpty) {
      return productName!;
    }
    if (brands != null && brands!.isNotEmpty) {
      return brands!;
    }
    return 'Sản phẩm #$barcode';
  }

  // Category đầu tiên (để map với FoodCategory)
  String? get primaryCategory {
    if (categories == null || categories!.isEmpty) return null;

    final categoryList = categories!.split(',');
    if (categoryList.isEmpty) return null;

    return categoryList.first.trim();
  }
}
