import 'package:flutter/material.dart';
import '../models/nutrition_facts.dart';
import '../models/vitamin.dart';
import '../utils/app_colors_v2.dart';
import '../utils/app_typography_v2.dart';

/// Vitamins Grid Widget
///
/// Displays vitamins in a grid format with:
/// - Icon and name
/// - Amount per serving
/// - Percentage of RDA
/// - Color-coded progress bar
class VitaminsGrid extends StatelessWidget {
  final NutritionFacts nutrition;
  final List<Vitamin> vitamins;
  final String gender;
  final bool isPregnant;
  final bool isLactating;

  const VitaminsGrid({
    super.key,
    required this.nutrition,
    required this.vitamins,
    this.gender = 'female',
    this.isPregnant = false,
    this.isLactating = false,
  });

  @override
  Widget build(BuildContext context) {
    // Map vitamins to their values from nutrition facts
    final vitaminData = _getVitaminData();

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColorsV2.gradientCard,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColorsV2.doveGray,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColorsV2.charcoalSoft.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColorsV2.lavenderMist.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Text('💊', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  'Vitamins',
                  style: AppTypographyV2.titleMedium(),
                ),
                const Spacer(),
                Text(
                  '${vitaminData.where((v) => v['percentage'] > 10).length}/${vitaminData.length}',
                  style: AppTypographyV2.labelMedium(
                    color: AppColorsV2.slateMuted,
                  ),
                ),
              ],
            ),
          ),

          // Grid
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: vitaminData.length,
              itemBuilder: (context, index) {
                final data = vitaminData[index];
                return _buildVitaminCard(
                  icon: data['icon'] as String,
                  code: data['code'] as String,
                  name: data['name'] as String,
                  amount: data['amount'] as double,
                  unit: data['unit'] as String,
                  percentage: data['percentage'] as double,
                  color: data['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitaminCard({
    required String icon,
    required String code,
    required String name,
    required double amount,
    required String unit,
    required double percentage,
    required Color color,
  }) {
    // Color intensity based on percentage
    Color bgColor = percentage >= 100
        ? AppColorsV2.mintCream
        : percentage >= 50
            ? AppColorsV2.peachBlossom
            : AppColorsV2.coralBlush.withOpacity(0.3);

    Color borderColor = percentage >= 100
        ? AppColorsV2.mintFresh
        : percentage >= 50
            ? AppColorsV2.goldenHour
            : AppColorsV2.coralBlush;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and code
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  code,
                  style: AppTypographyV2.labelSmall(color: color).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${amount.toStringAsFixed(1)}$unit',
                style: AppTypographyV2.numberMedium().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: AppTypographyV2.bodySmall(
                  color: AppColorsV2.slateMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // Progress bar and percentage
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (percentage / 100).clamp(0, 1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: AppTypographyV2.labelSmall(color: color).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getVitaminData() {
    final vitaminMap = {
      'A': nutrition.vitaminA,
      'B1': nutrition.vitaminB1,
      'B2': nutrition.vitaminB2,
      'B3': nutrition.vitaminB3,
      'B6': nutrition.vitaminB6,
      'B12': nutrition.vitaminB12,
      'C': nutrition.vitaminC,
      'D': nutrition.vitaminD,
      'E': nutrition.vitaminE,
      'K': nutrition.vitaminK,
    };

    List<Map<String, dynamic>> result = [];

    for (var vitamin in vitamins) {
      final amount = vitaminMap[vitamin.code] ?? 0.0;
      final rda = vitamin.getRDAForProfile(
        gender: gender,
        isPregnant: isPregnant,
        isLactating: isLactating,
      );
      final percentage = rda > 0 ? (amount / rda) * 100 : 0.0;

      final colorHex = vitamin.color;
      final color = Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);

      result.add({
        'icon': vitamin.icon,
        'code': vitamin.code,
        'name': vitamin.name,
        'amount': amount,
        'unit': vitamin.unit,
        'percentage': percentage,
        'color': color,
        'rda': rda,
      });
    }

    // Sort by percentage (highest first)
    result.sort((a, b) => (b['percentage'] as double).compareTo(a['percentage'] as double));

    return result;
  }
}

/// Compact Vitamins Summary
class CompactVitaminsSummary extends StatelessWidget {
  final NutritionFacts nutrition;
  final List<Vitamin> vitamins;

  const CompactVitaminsSummary({
    super.key,
    required this.nutrition,
    required this.vitamins,
  });

  @override
  Widget build(BuildContext context) {
    // Get top 3 vitamins
    final vitaminData = _getTopVitamins(3);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColorsV2.lavenderMist.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColorsV2.lavenderMist,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('💊', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                'Top Vitamins',
                style: AppTypographyV2.labelLarge(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...vitaminData.map((data) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(data['icon'] as String),
                        const SizedBox(width: 6),
                        Text(
                          data['code'] as String,
                          style: AppTypographyV2.bodySmall(),
                        ),
                      ],
                    ),
                    Text(
                      '${(data['percentage'] as double).toStringAsFixed(0)}%',
                      style: AppTypographyV2.labelSmall(
                        color: data['color'] as Color,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getTopVitamins(int count) {
    final vitaminMap = {
      'A': nutrition.vitaminA,
      'B1': nutrition.vitaminB1,
      'B2': nutrition.vitaminB2,
      'B3': nutrition.vitaminB3,
      'B6': nutrition.vitaminB6,
      'B12': nutrition.vitaminB12,
      'C': nutrition.vitaminC,
      'D': nutrition.vitaminD,
      'E': nutrition.vitaminE,
      'K': nutrition.vitaminK,
    };

    List<Map<String, dynamic>> result = [];

    for (var vitamin in vitamins) {
      final amount = vitaminMap[vitamin.code] ?? 0.0;
      if (amount > 0) {
        final rda = vitamin.rdaFemale; // Use default female RDA
        final percentage = rda > 0 ? (amount / rda) * 100 : 0.0;

        final colorHex = vitamin.color;
        final color = Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);

        result.add({
          'icon': vitamin.icon,
          'code': vitamin.code,
          'percentage': percentage,
          'color': color,
        });
      }
    }

    // Sort by percentage and take top N
    result.sort((a, b) => (b['percentage'] as double).compareTo(a['percentage'] as double));
    return result.take(count).toList();
  }
}
