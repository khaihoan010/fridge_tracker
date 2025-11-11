import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nutrition_facts.dart';

/// USDA FoodData Central API Service
///
/// To use this service, you need a FREE API key from USDA:
/// 1. Go to: https://fdc.nal.usda.gov/api-key-signup.html
/// 2. Sign up with your email (takes 1 minute)
/// 3. Copy your API key and paste it below
///
/// API Documentation: https://fdc.nal.usda.gov/api-guide.html
class USDAApiService {
  static const String _baseUrl = 'https://api.nal.usda.gov/fdc/v1';

  // TODO: Replace with your actual API key from https://fdc.nal.usda.gov/api-key-signup.html
  static const String _apiKey = 'DEMO_KEY'; // TEMPORARY - Replace with real key!

  static final USDAApiService instance = USDAApiService._init();
  USDAApiService._init();

  /// Search for foods by query
  ///
  /// Example: searchFoods('tomato')
  /// Returns list of matching foods with their FDC IDs
  Future<List<USDAFood>> searchFoods(String query, {int pageSize = 10}) async {
    if (_apiKey == 'DEMO_KEY') {
      print('⚠️  WARNING: Using DEMO_KEY. Please get a real API key from:');
      print('   https://fdc.nal.usda.gov/api-key-signup.html');
    }

    try {
      final uri = Uri.parse('$_baseUrl/foods/search').replace(
        queryParameters: {
          'query': query,
          'api_key': _apiKey,
          'pageSize': pageSize.toString(),
          'dataType': 'Survey (FNDDS)', // Most comprehensive nutrition data
        },
      );

      print('🔍 Searching USDA for: $query');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final foods = (data['foods'] as List? ?? [])
            .map((food) => USDAFood.fromJson(food))
            .toList();

        print('✅ Found ${foods.length} foods');
        return foods;
      } else if (response.statusCode == 403) {
        throw Exception('API Key invalid. Please get a valid key from https://fdc.nal.usda.gov/api-key-signup.html');
      } else {
        throw Exception('Failed to search foods: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('❌ Error searching USDA foods: $e');
      return [];
    }
  }

  /// Get detailed nutrition facts for a specific food
  ///
  /// Example: getNutritionFacts('168462') for tomatoes
  Future<NutritionFacts?> getNutritionFacts(String fdcId, int foodId) async {
    try {
      final uri = Uri.parse('$_baseUrl/food/$fdcId').replace(
        queryParameters: {
          'api_key': _apiKey,
        },
      );

      print('📊 Getting nutrition facts for FDC ID: $fdcId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final nutrition = NutritionFacts.fromUSDAJson(data, foodId);

        print('✅ Got nutrition data: ${nutrition.calories} kcal, ${nutrition.protein}g protein');
        return nutrition;
      } else if (response.statusCode == 403) {
        throw Exception('API Key invalid. Please get a valid key from https://fdc.nal.usda.gov/api-key-signup.html');
      } else {
        print('❌ Failed to get nutrition: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Error getting nutrition facts: $e');
      return null;
    }
  }

  /// Search and get nutrition in one call
  ///
  /// Example: searchAndGetNutrition('tomato', foodId: 1)
  Future<NutritionFacts?> searchAndGetNutrition(String query, {required int foodId}) async {
    final foods = await searchFoods(query, pageSize: 1);

    if (foods.isEmpty) {
      print('⚠️  No foods found for: $query');
      return null;
    }

    final firstFood = foods.first;
    print('📦 Using: ${firstFood.description}');

    return await getNutritionFacts(firstFood.fdcId, foodId);
  }

  /// Check if API key is valid
  Future<bool> testApiKey() async {
    try {
      final foods = await searchFoods('apple', pageSize: 1);
      return foods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

/// USDA Food search result
class USDAFood {
  final String fdcId;
  final String description;
  final String? category;
  final String? dataType;

  USDAFood({
    required this.fdcId,
    required this.description,
    this.category,
    this.dataType,
  });

  factory USDAFood.fromJson(Map<String, dynamic> json) {
    return USDAFood(
      fdcId: json['fdcId']?.toString() ?? '',
      description: json['description'] ?? '',
      category: json['foodCategory'],
      dataType: json['dataType'],
    );
  }

  @override
  String toString() {
    return 'USDAFood(fdcId: $fdcId, description: $description, category: $category)';
  }
}
