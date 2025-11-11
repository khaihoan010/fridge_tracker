class NutritionFacts {
  final int id;
  final int foodId;

  // Macros (per 100g)
  final double calories;
  final double protein;
  final double fat;
  final double saturatedFat;
  final double transFat;
  final double carbohydrates;
  final double fiber;
  final double sugar;
  final double sodium;
  final double cholesterol;

  // Vitamins (per 100g)
  final double vitaminA;
  final double vitaminB1;
  final double vitaminB2;
  final double vitaminB3;
  final double vitaminB6;
  final double vitaminB12;
  final double vitaminC;
  final double vitaminD;
  final double vitaminE;
  final double vitaminK;
  final double folate;

  // Minerals (per 100g)
  final double calcium;
  final double iron;
  final double magnesium;
  final double phosphorus;
  final double potassium;
  final double zinc;

  // Metadata
  final double servingSize;
  final String servingUnit;
  final int healthScore;
  final List<String> allergens;
  final List<String> dietTags;
  final String dataSource;
  final String? sourceId;
  final DateTime? lastUpdated;

  NutritionFacts({
    required this.id,
    required this.foodId,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.saturatedFat,
    required this.transFat,
    required this.carbohydrates,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.cholesterol,
    required this.vitaminA,
    required this.vitaminB1,
    required this.vitaminB2,
    required this.vitaminB3,
    required this.vitaminB6,
    required this.vitaminB12,
    required this.vitaminC,
    required this.vitaminD,
    required this.vitaminE,
    required this.vitaminK,
    required this.folate,
    required this.calcium,
    required this.iron,
    required this.magnesium,
    required this.phosphorus,
    required this.potassium,
    required this.zinc,
    required this.servingSize,
    required this.servingUnit,
    required this.healthScore,
    required this.allergens,
    required this.dietTags,
    required this.dataSource,
    this.sourceId,
    this.lastUpdated,
  });

  /// Create from database map
  factory NutritionFacts.fromMap(Map<String, dynamic> map) {
    return NutritionFacts(
      id: map['id'] ?? 0,
      foodId: map['food_id'] ?? 0,
      calories: (map['calories'] ?? 0).toDouble(),
      protein: (map['protein'] ?? 0).toDouble(),
      fat: (map['fat'] ?? 0).toDouble(),
      saturatedFat: (map['saturated_fat'] ?? 0).toDouble(),
      transFat: (map['trans_fat'] ?? 0).toDouble(),
      carbohydrates: (map['carbohydrates'] ?? 0).toDouble(),
      fiber: (map['fiber'] ?? 0).toDouble(),
      sugar: (map['sugar'] ?? 0).toDouble(),
      sodium: (map['sodium'] ?? 0).toDouble(),
      cholesterol: (map['cholesterol'] ?? 0).toDouble(),
      vitaminA: (map['vitamin_a'] ?? 0).toDouble(),
      vitaminB1: (map['vitamin_b1'] ?? 0).toDouble(),
      vitaminB2: (map['vitamin_b2'] ?? 0).toDouble(),
      vitaminB3: (map['vitamin_b3'] ?? 0).toDouble(),
      vitaminB6: (map['vitamin_b6'] ?? 0).toDouble(),
      vitaminB12: (map['vitamin_b12'] ?? 0).toDouble(),
      vitaminC: (map['vitamin_c'] ?? 0).toDouble(),
      vitaminD: (map['vitamin_d'] ?? 0).toDouble(),
      vitaminE: (map['vitamin_e'] ?? 0).toDouble(),
      vitaminK: (map['vitamin_k'] ?? 0).toDouble(),
      folate: (map['folate'] ?? 0).toDouble(),
      calcium: (map['calcium'] ?? 0).toDouble(),
      iron: (map['iron'] ?? 0).toDouble(),
      magnesium: (map['magnesium'] ?? 0).toDouble(),
      phosphorus: (map['phosphorus'] ?? 0).toDouble(),
      potassium: (map['potassium'] ?? 0).toDouble(),
      zinc: (map['zinc'] ?? 0).toDouble(),
      servingSize: (map['serving_size'] ?? 100).toDouble(),
      servingUnit: map['serving_unit'] ?? 'g',
      healthScore: map['health_score'] ?? 50,
      allergens: (map['allergens'] as String?)?.split(',').where((s) => s.isNotEmpty).toList() ?? [],
      dietTags: (map['diet_tags'] as String?)?.split(',').where((s) => s.isNotEmpty).toList() ?? [],
      dataSource: map['data_source'] ?? 'manual',
      sourceId: map['source_id'],
      lastUpdated: map['last_updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_updated'] as int)
          : null,
    );
  }

  /// Convert to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id == 0 ? null : id, // Auto-increment
      'food_id': foodId,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'saturated_fat': saturatedFat,
      'trans_fat': transFat,
      'carbohydrates': carbohydrates,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'cholesterol': cholesterol,
      'vitamin_a': vitaminA,
      'vitamin_b1': vitaminB1,
      'vitamin_b2': vitaminB2,
      'vitamin_b3': vitaminB3,
      'vitamin_b6': vitaminB6,
      'vitamin_b12': vitaminB12,
      'vitamin_c': vitaminC,
      'vitamin_d': vitaminD,
      'vitamin_e': vitaminE,
      'vitamin_k': vitaminK,
      'folate': folate,
      'calcium': calcium,
      'iron': iron,
      'magnesium': magnesium,
      'phosphorus': phosphorus,
      'potassium': potassium,
      'zinc': zinc,
      'serving_size': servingSize,
      'serving_unit': servingUnit,
      'health_score': healthScore,
      'allergens': allergens.join(','),
      'diet_tags': dietTags.join(','),
      'data_source': dataSource,
      'source_id': sourceId,
      'last_updated': lastUpdated?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    };
  }

  /// Parse from USDA API response
  factory NutritionFacts.fromUSDAJson(Map<String, dynamic> json, int foodId) {
    final nutrients = json['foodNutrients'] as List? ?? [];

    // Helper to extract nutrient value by name
    double getNutrient(List<String> searchTerms) {
      try {
        for (var term in searchTerms) {
          final nutrient = nutrients.firstWhere(
            (n) {
              final name = (n['nutrient']?['name'] as String? ?? '').toLowerCase();
              return name.contains(term.toLowerCase());
            },
            orElse: () => null,
          );
          if (nutrient != null) {
            return (nutrient['amount'] as num?)?.toDouble() ?? 0.0;
          }
        }
        return 0.0;
      } catch (e) {
        return 0.0;
      }
    }

    return NutritionFacts(
      id: 0, // Will be set by database
      foodId: foodId,
      calories: getNutrient(['energy', 'calories']),
      protein: getNutrient(['protein']),
      fat: getNutrient(['total lipid', 'fat']),
      saturatedFat: getNutrient(['fatty acids, total saturated', 'saturated']),
      transFat: getNutrient(['fatty acids, total trans', 'trans']),
      carbohydrates: getNutrient(['carbohydrate']),
      fiber: getNutrient(['fiber', 'dietary fiber']),
      sugar: getNutrient(['sugars, total', 'sugars']),
      sodium: getNutrient(['sodium']),
      cholesterol: getNutrient(['cholesterol']),
      vitaminA: getNutrient(['vitamin a', 'retinol']),
      vitaminB1: getNutrient(['thiamin', 'vitamin b-1']),
      vitaminB2: getNutrient(['riboflavin', 'vitamin b-2']),
      vitaminB3: getNutrient(['niacin', 'vitamin b-3']),
      vitaminB6: getNutrient(['vitamin b-6', 'pyridoxine']),
      vitaminB12: getNutrient(['vitamin b-12', 'cobalamin']),
      vitaminC: getNutrient(['vitamin c', 'ascorbic acid']),
      vitaminD: getNutrient(['vitamin d']),
      vitaminE: getNutrient(['vitamin e', 'alpha-tocopherol']),
      vitaminK: getNutrient(['vitamin k']),
      folate: getNutrient(['folate', 'folic acid']),
      calcium: getNutrient(['calcium']),
      iron: getNutrient(['iron']),
      magnesium: getNutrient(['magnesium']),
      phosphorus: getNutrient(['phosphorus']),
      potassium: getNutrient(['potassium']),
      zinc: getNutrient(['zinc']),
      servingSize: 100,
      servingUnit: 'g',
      healthScore: 50, // Will calculate later
      allergens: [],
      dietTags: [],
      dataSource: 'usda',
      sourceId: json['fdcId']?.toString(),
      lastUpdated: DateTime.now(),
    );
  }

  /// Create a copy with updated fields
  NutritionFacts copyWith({
    int? id,
    int? foodId,
    double? calories,
    double? protein,
    double? fat,
    double? saturatedFat,
    double? transFat,
    double? carbohydrates,
    double? fiber,
    double? sugar,
    double? sodium,
    double? cholesterol,
    double? vitaminA,
    double? vitaminB1,
    double? vitaminB2,
    double? vitaminB3,
    double? vitaminB6,
    double? vitaminB12,
    double? vitaminC,
    double? vitaminD,
    double? vitaminE,
    double? vitaminK,
    double? folate,
    double? calcium,
    double? iron,
    double? magnesium,
    double? phosphorus,
    double? potassium,
    double? zinc,
    double? servingSize,
    String? servingUnit,
    int? healthScore,
    List<String>? allergens,
    List<String>? dietTags,
    String? dataSource,
    String? sourceId,
    DateTime? lastUpdated,
  }) {
    return NutritionFacts(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      saturatedFat: saturatedFat ?? this.saturatedFat,
      transFat: transFat ?? this.transFat,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
      cholesterol: cholesterol ?? this.cholesterol,
      vitaminA: vitaminA ?? this.vitaminA,
      vitaminB1: vitaminB1 ?? this.vitaminB1,
      vitaminB2: vitaminB2 ?? this.vitaminB2,
      vitaminB3: vitaminB3 ?? this.vitaminB3,
      vitaminB6: vitaminB6 ?? this.vitaminB6,
      vitaminB12: vitaminB12 ?? this.vitaminB12,
      vitaminC: vitaminC ?? this.vitaminC,
      vitaminD: vitaminD ?? this.vitaminD,
      vitaminE: vitaminE ?? this.vitaminE,
      vitaminK: vitaminK ?? this.vitaminK,
      folate: folate ?? this.folate,
      calcium: calcium ?? this.calcium,
      iron: iron ?? this.iron,
      magnesium: magnesium ?? this.magnesium,
      phosphorus: phosphorus ?? this.phosphorus,
      potassium: potassium ?? this.potassium,
      zinc: zinc ?? this.zinc,
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      healthScore: healthScore ?? this.healthScore,
      allergens: allergens ?? this.allergens,
      dietTags: dietTags ?? this.dietTags,
      dataSource: dataSource ?? this.dataSource,
      sourceId: sourceId ?? this.sourceId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  String toString() {
    return 'NutritionFacts(id: $id, foodId: $foodId, calories: $calories, protein: $protein, health_score: $healthScore)';
  }
}
