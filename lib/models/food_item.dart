class FoodItem {
  final int? id;
  final String name;
  final String category;
  final String storageLocation;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final String? imagePath;
  final String? barcode;
  final double quantity;
  final String unit;
  final String? notes;

  FoodItem({
    this.id,
    required this.name,
    required this.category,
    required this.storageLocation,
    required this.purchaseDate,
    required this.expiryDate,
    this.imagePath,
    this.barcode,
    this.quantity = 1.0,
    this.unit = 'cái',
    this.notes,
  });

  // Tính số ngày còn lại đến hạn
  int get daysUntilExpiry {
    final now = DateTime.now();
    final difference = expiryDate.difference(DateTime(now.year, now.month, now.day));
    return difference.inDays;
  }

  // Kiểm tra trạng thái hết hạn
  ExpiryStatus get expiryStatus {
    final days = daysUntilExpiry;
    if (days < 0) return ExpiryStatus.expired;
    if (days <= 3) return ExpiryStatus.expiringSoon;
    return ExpiryStatus.fresh;
  }

  // Chuyển đổi từ Map sang FoodItem
  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: map['category'] as String,
      storageLocation: map['storage_location'] as String,
      purchaseDate: DateTime.parse(map['purchase_date'] as String),
      expiryDate: DateTime.parse(map['expiry_date'] as String),
      imagePath: map['image_path'] as String?,
      barcode: map['barcode'] as String?,
      quantity: (map['quantity'] as num).toDouble(),
      unit: map['unit'] as String,
      notes: map['notes'] as String?,
    );
  }

  // Chuyển đổi từ FoodItem sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'storage_location': storageLocation,
      'purchase_date': purchaseDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'image_path': imagePath,
      'barcode': barcode,
      'quantity': quantity,
      'unit': unit,
      'notes': notes,
    };
  }

  // Copy with (để tạo bản sao với một số thuộc tính thay đổi)
  FoodItem copyWith({
    int? id,
    String? name,
    String? category,
    String? storageLocation,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    String? imagePath,
    String? barcode,
    double? quantity,
    String? unit,
    String? notes,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      storageLocation: storageLocation ?? this.storageLocation,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      imagePath: imagePath ?? this.imagePath,
      barcode: barcode ?? this.barcode,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
    );
  }
}

// Enum cho trạng thái hết hạn
enum ExpiryStatus {
  fresh,        // Còn hạn > 3 ngày
  expiringSoon, // Sắp hết hạn <= 3 ngày
  expired,      // Đã hết hạn
}
