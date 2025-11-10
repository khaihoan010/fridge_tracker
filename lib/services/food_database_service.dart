import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/food_template.dart';

/// 🍎 Food Database Service
/// Manages food templates with shelf life data based on USDA FoodKeeper standards
class FoodDatabaseService {
  static final FoodDatabaseService _instance = FoodDatabaseService._internal();
  static FoodDatabaseService get instance => _instance;

  FoodDatabaseService._internal();

  List<FoodTemplate> _foodDatabase = [];
  bool _isLoaded = false;

  /// Check if database is loaded
  bool get isLoaded => _isLoaded;

  /// Get all food templates
  List<FoodTemplate> get allFoods => _foodDatabase;

  /// Load food database from JSON file
  Future<void> loadDatabase() async {
    if (_isLoaded) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/food_database.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      _foodDatabase = [];

      // Parse each category
      for (final category in jsonData.entries) {
        final List<dynamic> items = category.value as List<dynamic>;
        for (final item in items) {
          try {
            _foodDatabase.add(FoodTemplate.fromJson(item as Map<String, dynamic>));
          } catch (e) {
            print('Error parsing food item: $e');
          }
        }
      }

      _isLoaded = true;
      print('✅ Loaded ${_foodDatabase.length} food items');
    } catch (e) {
      print('❌ Error loading food database: $e');
      _isLoaded = false;
    }
  }

  /// Search foods by name with fuzzy matching
  /// Returns list of matching FoodTemplate objects
  Future<List<FoodTemplate>> searchFood(String query) async {
    if (!_isLoaded) {
      await loadDatabase();
    }

    if (query.trim().isEmpty) {
      return [];
    }

    final String normalizedQuery = _normalizeVietnamese(query.toLowerCase());
    final List<FoodTemplate> results = [];

    for (final food in _foodDatabase) {
      // Check if name matches
      final String normalizedName = _normalizeVietnamese(food.name.toLowerCase());
      if (normalizedName.contains(normalizedQuery)) {
        results.add(food);
        continue;
      }

      // Check if English name matches
      if (food.nameEn != null) {
        final String normalizedNameEn = food.nameEn!.toLowerCase();
        if (normalizedNameEn.contains(normalizedQuery)) {
          results.add(food);
          continue;
        }
      }

      // Check if any keyword matches
      for (final keyword in food.keywords) {
        final String normalizedKeyword = _normalizeVietnamese(keyword.toLowerCase());
        if (normalizedKeyword.contains(normalizedQuery)) {
          results.add(food);
          break;
        }
      }
    }

    // Sort results by relevance
    results.sort((a, b) {
      final aName = _normalizeVietnamese(a.name.toLowerCase());
      final bName = _normalizeVietnamese(b.name.toLowerCase());

      // Exact match first
      if (aName == normalizedQuery) return -1;
      if (bName == normalizedQuery) return 1;

      // Starts with query
      if (aName.startsWith(normalizedQuery) && !bName.startsWith(normalizedQuery)) return -1;
      if (!aName.startsWith(normalizedQuery) && bName.startsWith(normalizedQuery)) return 1;

      // Alphabetical
      return aName.compareTo(bName);
    });

    // Limit to 10 results for performance
    return results.take(10).toList();
  }

  /// Get food template by ID
  Future<FoodTemplate?> getFoodById(String id) async {
    if (!_isLoaded) {
      await loadDatabase();
    }

    try {
      return _foodDatabase.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get foods by category
  Future<List<FoodTemplate>> getFoodsByCategory(String category) async {
    if (!_isLoaded) {
      await loadDatabase();
    }

    return _foodDatabase.where((food) => food.category == category).toList();
  }

  /// Get suggested expiry date for a food item
  DateTime getSuggestedExpiryDate({
    required String foodId,
    required String storageLocation,
    required DateTime purchaseDate,
  }) {
    final food = _foodDatabase.where((f) => f.id == foodId).firstOrNull;

    if (food == null) {
      // Default to 7 days if food not found
      return purchaseDate.add(const Duration(days: 7));
    }

    return food.calculateExpiryDate(
      storageLocation: storageLocation,
      purchaseDate: purchaseDate,
    );
  }

  /// Normalize Vietnamese text for better matching
  /// Removes diacritics and converts to lowercase
  String _normalizeVietnamese(String text) {
    const vietnamese = 'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ';
    const normalized = 'aaaaaâââââăăăăăeeeeeêêêêếiiiiioooooôôôôôơơơơơuuuuuưưưưưyyyyyđ';

    String result = text;
    for (int i = 0; i < vietnamese.length; i++) {
      result = result.replaceAll(vietnamese[i], normalized[i]);
    }
    return result;
  }

  /// Clear cache and reload database
  Future<void> reloadDatabase() async {
    _isLoaded = false;
    _foodDatabase = [];
    await loadDatabase();
  }
}
