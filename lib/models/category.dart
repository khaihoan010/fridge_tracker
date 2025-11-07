import 'package:flutter/material.dart';

class FoodCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const FoodCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  // Danh sách các danh mục mặc định
  static const List<FoodCategory> defaultCategories = [
    FoodCategory(
      id: 'vegetables',
      name: 'Rau củ',
      icon: Icons.eco,
      color: Colors.green,
    ),
    FoodCategory(
      id: 'fruits',
      name: 'Trái cây',
      icon: Icons.apple,
      color: Colors.orange,
    ),
    FoodCategory(
      id: 'meat',
      name: 'Thịt',
      icon: Icons.set_meal,
      color: Colors.red,
    ),
    FoodCategory(
      id: 'seafood',
      name: 'Hải sản',
      icon: Icons.phishing,
      color: Colors.blue,
    ),
    FoodCategory(
      id: 'dairy',
      name: 'Sữa & Trứng',
      icon: Icons.egg,
      color: Colors.amber,
    ),
    FoodCategory(
      id: 'beverages',
      name: 'Đồ uống',
      icon: Icons.local_drink,
      color: Colors.cyan,
    ),
    FoodCategory(
      id: 'frozen',
      name: 'Đồ đông lạnh',
      icon: Icons.ac_unit,
      color: Colors.lightBlue,
    ),
    FoodCategory(
      id: 'bakery',
      name: 'Bánh mì',
      icon: Icons.bakery_dining,
      color: Colors.brown,
    ),
    FoodCategory(
      id: 'condiments',
      name: 'Gia vị',
      icon: Icons.restaurant,
      color: Colors.deepOrange,
    ),
    FoodCategory(
      id: 'others',
      name: 'Khác',
      icon: Icons.inventory_2,
      color: Colors.grey,
    ),
  ];

  // Lấy category theo ID
  static FoodCategory getById(String id) {
    return defaultCategories.firstWhere(
      (cat) => cat.id == id,
      orElse: () => defaultCategories.last, // Trả về 'Khác' nếu không tìm thấy
    );
  }

  // Lấy category theo name
  static FoodCategory getByName(String name) {
    return defaultCategories.firstWhere(
      (cat) => cat.name == name,
      orElse: () => defaultCategories.last,
    );
  }
}

// Vị trí lưu trữ
class StorageLocation {
  final String id;
  final String name;
  final IconData icon;

  const StorageLocation({
    required this.id,
    required this.name,
    required this.icon,
  });

  static const List<StorageLocation> defaultLocations = [
    StorageLocation(
      id: 'fridge',
      name: 'Tủ lạnh',
      icon: Icons.kitchen,
    ),
    StorageLocation(
      id: 'freezer',
      name: 'Tủ đông',
      icon: Icons.ac_unit,
    ),
    StorageLocation(
      id: 'pantry',
      name: 'Tủ khô',
      icon: Icons.inventory,
    ),
    StorageLocation(
      id: 'counter',
      name: 'Bàn bếp',
      icon: Icons.countertops,
    ),
  ];

  static StorageLocation getById(String id) {
    return defaultLocations.firstWhere(
      (loc) => loc.id == id,
      orElse: () => defaultLocations.first,
    );
  }

  static StorageLocation getByName(String name) {
    return defaultLocations.firstWhere(
      (loc) => loc.name == name,
      orElse: () => defaultLocations.first,
    );
  }
}
