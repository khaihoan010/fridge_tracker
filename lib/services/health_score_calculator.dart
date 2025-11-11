import '../models/nutrition_facts.dart';

/// Health Score Calculator
///
/// Calculates a health score (0-100) for foods based on their nutrition facts.
/// Algorithm considers:
/// - Positive factors: fiber, protein, vitamins/minerals (+30 max)
/// - Negative factors: sugar, sodium, saturated fat (-30 max)
/// - Nutrient density bonus (+20 max)
/// - Base score: 50
class HealthScoreCalculator {
  static final HealthScoreCalculator instance = HealthScoreCalculator._init();
  HealthScoreCalculator._init();

  /// Calculate health score for a food (0-100)
  HealthScoreResult calculate(NutritionFacts nutrition) {
    double score = 50.0; // Base score

    // Positive factors (+30 max)
    double positiveScore = 0;

    // Fiber: +1 per gram (max +10)
    positiveScore += (nutrition.fiber * 1.0).clamp(0, 10);

    // Protein: +0.5 per gram (max +10)
    positiveScore += (nutrition.protein * 0.5).clamp(0, 10);

    // Vitamins & Minerals: +0.5 per 10% of any nutrient (max +10)
    double vitaminScore = 0;
    vitaminScore += _vitaminScore(nutrition.vitaminA, 900); // mcg
    vitaminScore += _vitaminScore(nutrition.vitaminB1, 1.2); // mg
    vitaminScore += _vitaminScore(nutrition.vitaminB2, 1.3); // mg
    vitaminScore += _vitaminScore(nutrition.vitaminB3, 16); // mg
    vitaminScore += _vitaminScore(nutrition.vitaminB6, 1.7); // mg
    vitaminScore += _vitaminScore(nutrition.vitaminB12, 2.4); // mcg
    vitaminScore += _vitaminScore(nutrition.vitaminC, 90); // mg
    vitaminScore += _vitaminScore(nutrition.vitaminD, 20); // mcg
    vitaminScore += _vitaminScore(nutrition.vitaminE, 15); // mg
    vitaminScore += _vitaminScore(nutrition.vitaminK, 120); // mcg
    vitaminScore += _vitaminScore(nutrition.folate, 400); // mcg
    vitaminScore += _vitaminScore(nutrition.calcium, 1000); // mg
    vitaminScore += _vitaminScore(nutrition.iron, 18); // mg
    vitaminScore += _vitaminScore(nutrition.magnesium, 400); // mg
    vitaminScore += _vitaminScore(nutrition.phosphorus, 700); // mg
    vitaminScore += _vitaminScore(nutrition.potassium, 3400); // mg
    vitaminScore += _vitaminScore(nutrition.zinc, 11); // mg
    positiveScore += vitaminScore.clamp(0, 10);

    score += positiveScore;

    // Negative factors (-30 max)
    double negativeScore = 0;

    // Sugar: -0.5 per gram (max -10)
    negativeScore -= (nutrition.sugar * 0.5).clamp(0, 10);

    // Sodium: -0.01 per mg (max -10)
    negativeScore -= (nutrition.sodium * 0.01).clamp(0, 10);

    // Saturated Fat: -1 per gram (max -10)
    negativeScore -= (nutrition.saturatedFat * 1.0).clamp(0, 10);

    score += negativeScore;

    // Nutrient density bonus (+20 max)
    // High nutrition relative to calories
    if (nutrition.calories > 0) {
      double nutrientDensity = 0;

      // Protein density: +5 if >20% of calories from protein
      double proteinCalories = nutrition.protein * 4;
      if (proteinCalories / nutrition.calories > 0.2) {
        nutrientDensity += 5;
      }

      // Fiber density: +5 if >3g fiber per 100 kcal
      if (nutrition.fiber / (nutrition.calories / 100) > 3) {
        nutrientDensity += 5;
      }

      // Low calorie density: +5 if <100 kcal per 100g
      if (nutrition.calories < 100) {
        nutrientDensity += 5;
      }

      // Vitamin density: +5 if any vitamin >30% RDA
      if (vitaminScore > 3) {
        nutrientDensity += 5;
      }

      score += nutrientDensity.clamp(0, 20);
    }

    // Clamp final score to 0-100
    score = score.clamp(0, 100);

    // Generate insights
    List<String> insights = _generateInsights(nutrition);

    // Determine rating
    HealthRating rating = _getRating(score);

    return HealthScoreResult(
      score: score.round(),
      rating: rating,
      insights: insights,
      positiveScore: positiveScore,
      negativeScore: negativeScore,
    );
  }

  /// Calculate vitamin/mineral score contribution
  double _vitaminScore(double amount, double rda) {
    if (amount == 0) return 0;
    double percentRDA = (amount / rda) * 100;
    return (percentRDA / 10).clamp(0, 1); // +0.5 per 10% RDA
  }

  /// Get health rating from score
  HealthRating _getRating(double score) {
    if (score >= 80) return HealthRating.excellent;
    if (score >= 65) return HealthRating.veryGood;
    if (score >= 50) return HealthRating.good;
    if (score >= 35) return HealthRating.moderate;
    return HealthRating.poor;
  }

  /// Generate health insights
  List<String> _generateInsights(NutritionFacts nutrition) {
    List<String> insights = [];

    // Protein
    if (nutrition.protein > 15) {
      insights.add('High protein content');
    } else if (nutrition.protein < 5) {
      insights.add('Low protein');
    }

    // Fiber
    if (nutrition.fiber > 5) {
      insights.add('Excellent source of fiber');
    } else if (nutrition.fiber > 2.5) {
      insights.add('Good source of fiber');
    }

    // Sugar
    if (nutrition.sugar > 20) {
      insights.add('Very high in sugar');
    } else if (nutrition.sugar > 10) {
      insights.add('High in sugar');
    } else if (nutrition.sugar < 2) {
      insights.add('Low in sugar');
    }

    // Sodium
    if (nutrition.sodium > 500) {
      insights.add('High sodium content');
    } else if (nutrition.sodium < 100) {
      insights.add('Low sodium');
    }

    // Fat
    if (nutrition.saturatedFat > 5) {
      insights.add('High in saturated fat');
    }
    if (nutrition.transFat > 0.5) {
      insights.add('Contains trans fat');
    }

    // Vitamins
    if (nutrition.vitaminC > 45) {
      insights.add('Rich in Vitamin C');
    }
    if (nutrition.vitaminA > 450) {
      insights.add('Rich in Vitamin A');
    }
    if (nutrition.vitaminD > 10) {
      insights.add('Good source of Vitamin D');
    }

    // Minerals
    if (nutrition.calcium > 300) {
      insights.add('High in calcium');
    }
    if (nutrition.iron > 5) {
      insights.add('Rich in iron');
    }
    if (nutrition.potassium > 1000) {
      insights.add('High potassium content');
    }

    // Calories
    if (nutrition.calories < 50) {
      insights.add('Very low calorie');
    } else if (nutrition.calories > 400) {
      insights.add('High calorie');
    }

    // Carbs
    if (nutrition.carbohydrates < 5) {
      insights.add('Low carb');
    } else if (nutrition.carbohydrates > 50) {
      insights.add('High carb');
    }

    return insights;
  }

  /// Get emoji for health rating
  static String getEmoji(HealthRating rating) {
    switch (rating) {
      case HealthRating.excellent:
        return '🌟';
      case HealthRating.veryGood:
        return '✨';
      case HealthRating.good:
        return '⭐';
      case HealthRating.moderate:
        return '⚠️';
      case HealthRating.poor:
        return '❌';
    }
  }

  /// Get color for health rating
  static String getColor(HealthRating rating) {
    switch (rating) {
      case HealthRating.excellent:
        return '#00C853'; // Green
      case HealthRating.veryGood:
        return '#64DD17'; // Light green
      case HealthRating.good:
        return '#FFD600'; // Yellow
      case HealthRating.moderate:
        return '#FF6D00'; // Orange
      case HealthRating.poor:
        return '#DD2C00'; // Red
    }
  }

  /// Get label for health rating
  static String getLabel(HealthRating rating) {
    switch (rating) {
      case HealthRating.excellent:
        return 'Excellent';
      case HealthRating.veryGood:
        return 'Very Good';
      case HealthRating.good:
        return 'Good';
      case HealthRating.moderate:
        return 'Moderate';
      case HealthRating.poor:
        return 'Poor';
    }
  }

  /// Get Vietnamese label for health rating
  static String getLabelVi(HealthRating rating) {
    switch (rating) {
      case HealthRating.excellent:
        return 'Xuất sắc';
      case HealthRating.veryGood:
        return 'Rất tốt';
      case HealthRating.good:
        return 'Tốt';
      case HealthRating.moderate:
        return 'Trung bình';
      case HealthRating.poor:
        return 'Kém';
    }
  }
}

/// Health rating categories
enum HealthRating {
  excellent, // 80-100
  veryGood,  // 65-79
  good,      // 50-64
  moderate,  // 35-49
  poor,      // 0-34
}

/// Health score calculation result
class HealthScoreResult {
  final int score;
  final HealthRating rating;
  final List<String> insights;
  final double positiveScore;
  final double negativeScore;

  HealthScoreResult({
    required this.score,
    required this.rating,
    required this.insights,
    required this.positiveScore,
    required this.negativeScore,
  });

  @override
  String toString() {
    return 'HealthScoreResult(score: $score, rating: $rating, insights: ${insights.length})';
  }
}
