import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../database/database_helper.dart';
import '../services/notification_service.dart';
import '../services/image_service.dart';

class FoodProvider with ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final NotificationService _notificationService = NotificationService.instance;
  final ImageService _imageService = ImageService.instance;

  List<FoodItem> _foods = [];
  List<FoodItem> _filteredFoods = [];
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedLocation;
  FoodFilter _currentFilter = FoodFilter.all;

  bool _isLoading = false;

  // Getters
  List<FoodItem> get foods => _filteredFoods;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  String? get selectedLocation => _selectedLocation;
  FoodFilter get currentFilter => _currentFilter;

  // Thống kê
  int get totalFoods => _foods.length;
  int get expiredCount => _foods.where((f) => f.expiryStatus == ExpiryStatus.expired).length;
  int get expiringSoonCount => _foods.where((f) => f.expiryStatus == ExpiryStatus.expiringSoon).length;
  int get freshCount => _foods.where((f) => f.expiryStatus == ExpiryStatus.fresh).length;

  // Load tất cả thực phẩm
  Future<void> loadFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      _foods = await _db.getAllFoods();
      _applyFilters();
    } catch (e) {
      print('Error loading foods: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Thêm thực phẩm mới
  Future<bool> addFood(FoodItem food, int notifyDaysBefore) async {
    try {
      final id = await _db.insertFood(food);
      final newFood = food.copyWith(id: id);

      // Lên lịch thông báo
      await _notificationService.scheduleFoodExpiryNotification(
        newFood,
        notifyDaysBefore,
      );

      await loadFoods();
      return true;
    } catch (e) {
      print('Error adding food: $e');
      return false;
    }
  }

  // Cập nhật thực phẩm
  Future<bool> updateFood(FoodItem food, int notifyDaysBefore) async {
    try {
      await _db.updateFood(food);

      // Hủy thông báo cũ và lên lịch mới
      if (food.id != null) {
        await _notificationService.cancelNotification(food.id!);
        await _notificationService.scheduleFoodExpiryNotification(
          food,
          notifyDaysBefore,
        );
      }

      await loadFoods();
      return true;
    } catch (e) {
      print('Error updating food: $e');
      return false;
    }
  }

  // Xóa thực phẩm
  Future<bool> deleteFood(FoodItem food) async {
    try {
      if (food.id != null) {
        await _db.deleteFood(food.id!);

        // Hủy thông báo
        await _notificationService.cancelNotification(food.id!);

        // Xóa ảnh nếu có
        if (food.imagePath != null) {
          await _imageService.deleteImage(food.imagePath!);
        }
      }

      await loadFoods();
      return true;
    } catch (e) {
      print('Error deleting food: $e');
      return false;
    }
  }

  // Xóa tất cả thực phẩm đã hết hạn
  Future<void> deleteAllExpired() async {
    try {
      // Lấy danh sách thực phẩm hết hạn để xóa ảnh
      final expiredFoods = _foods.where((f) => f.expiryStatus == ExpiryStatus.expired);

      for (var food in expiredFoods) {
        if (food.id != null) {
          await _notificationService.cancelNotification(food.id!);
        }
        if (food.imagePath != null) {
          await _imageService.deleteImage(food.imagePath!);
        }
      }

      await _db.deleteExpiredFoods();
      await loadFoods();
    } catch (e) {
      print('Error deleting expired foods: $e');
    }
  }

  // Tìm kiếm
  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  // Filter theo danh mục
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  // Filter theo vị trí
  void filterByLocation(String? location) {
    _selectedLocation = location;
    _applyFilters();
  }

  // Filter theo trạng thái
  void filterByStatus(FoodFilter filter) {
    _currentFilter = filter;
    _applyFilters();
  }

  // Clear tất cả filters
  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _selectedLocation = null;
    _currentFilter = FoodFilter.all;
    _applyFilters();
  }

  // Áp dụng các filters
  void _applyFilters() {
    _filteredFoods = _foods;

    // Filter theo search query
    if (_searchQuery.isNotEmpty) {
      _filteredFoods = _filteredFoods.where((food) {
        return food.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter theo category
    if (_selectedCategory != null) {
      _filteredFoods = _filteredFoods.where((food) {
        return food.category == _selectedCategory;
      }).toList();
    }

    // Filter theo location
    if (_selectedLocation != null) {
      _filteredFoods = _filteredFoods.where((food) {
        return food.storageLocation == _selectedLocation;
      }).toList();
    }

    // Filter theo status
    switch (_currentFilter) {
      case FoodFilter.expired:
        _filteredFoods = _filteredFoods.where((food) {
          return food.expiryStatus == ExpiryStatus.expired;
        }).toList();
        break;
      case FoodFilter.expiringSoon:
        _filteredFoods = _filteredFoods.where((food) {
          return food.expiryStatus == ExpiryStatus.expiringSoon;
        }).toList();
        break;
      case FoodFilter.fresh:
        _filteredFoods = _filteredFoods.where((food) {
          return food.expiryStatus == ExpiryStatus.fresh;
        }).toList();
        break;
      case FoodFilter.all:
        // Không filter
        break;
    }

    notifyListeners();
  }

  // Lấy thống kê theo category
  Future<Map<String, int>> getCategoryStats() async {
    return await _db.getFoodCountByCategory();
  }

  // Refresh (pull to refresh)
  Future<void> refresh() async {
    await loadFoods();
  }
}

// Enum cho filter
enum FoodFilter {
  all,          // Tất cả
  expired,      // Đã hết hạn
  expiringSoon, // Sắp hết hạn
  fresh,        // Còn hạn
}
