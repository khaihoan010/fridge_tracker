/// 🍎 Food Template Model
/// Based on USDA FoodKeeper Database standards
class FoodTemplate {
  final String id;
  final String name;
  final String? nameEn;
  final String category;
  final ShelfLife shelfLife;
  final List<String> keywords;
  final String? storageTips;

  const FoodTemplate({
    required this.id,
    required this.name,
    this.nameEn,
    required this.category,
    required this.shelfLife,
    required this.keywords,
    this.storageTips,
  });

  /// Calculate expiry date based on storage location and purchase date
  DateTime calculateExpiryDate({
    required String storageLocation,
    required DateTime purchaseDate,
  }) {
    int? days;

    switch (storageLocation) {
      case 'fridge':
        days = shelfLife.fridge;
        break;
      case 'freezer':
        days = shelfLife.freezer;
        break;
      case 'pantry':
        days = shelfLife.pantry;
        break;
      default:
        days = shelfLife.fridge ?? shelfLife.pantry ?? 7;
    }

    // Default to 7 days if no data available
    days ??= 7;

    return purchaseDate.add(Duration(days: days));
  }

  /// Get recommended storage location
  String getRecommendedStorage() {
    // Prefer fridge if available
    if (shelfLife.fridge != null && shelfLife.fridge! > 0) {
      return 'fridge';
    }
    // Then freezer
    if (shelfLife.freezer != null && shelfLife.freezer! > 0) {
      return 'freezer';
    }
    // Finally pantry
    return 'pantry';
  }

  /// Get shelf life description for a storage location
  String getShelfLifeDescription(String storageLocation) {
    int? days;
    switch (storageLocation) {
      case 'fridge':
        days = shelfLife.fridge;
        break;
      case 'freezer':
        days = shelfLife.freezer;
        break;
      case 'pantry':
        days = shelfLife.pantry;
        break;
    }

    if (days == null || days == 0) {
      return 'Không nên bảo quản ở $storageLocation';
    }

    if (days == 1) {
      return '1 ngày';
    }

    if (days < 7) {
      return '$days ngày';
    }

    if (days < 30) {
      final weeks = (days / 7).round();
      return '$weeks tuần';
    }

    if (days < 365) {
      final months = (days / 30).round();
      return '$months tháng';
    }

    final years = (days / 365).round();
    return '$years năm';
  }

  factory FoodTemplate.fromJson(Map<String, dynamic> json) {
    return FoodTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['nameEn'] as String?,
      category: json['category'] as String,
      shelfLife: ShelfLife.fromJson(json['shelfLife'] as Map<String, dynamic>),
      keywords: (json['keywords'] as List<dynamic>).cast<String>(),
      storageTips: json['storageTips'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'category': category,
      'shelfLife': shelfLife.toJson(),
      'keywords': keywords,
      'storageTips': storageTips,
    };
  }
}

/// Shelf life data for different storage methods
/// All durations are in days
class ShelfLife {
  final int? pantry; // Room temperature / Pantry
  final int? fridge; // Refrigerator (40°F / 4°C)
  final int? freezer; // Freezer (0°F / -18°C)

  const ShelfLife({
    this.pantry,
    this.fridge,
    this.freezer,
  });

  factory ShelfLife.fromJson(Map<String, dynamic> json) {
    return ShelfLife(
      pantry: json['pantry'] as int?,
      fridge: json['fridge'] as int?,
      freezer: json['freezer'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pantry': pantry,
      'fridge': fridge,
      'freezer': freezer,
    };
  }
}
