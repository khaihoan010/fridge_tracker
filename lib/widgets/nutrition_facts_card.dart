import 'package:flutter/material.dart';
import '../models/nutrition_facts.dart';
import '../utils/app_colors_v2.dart';
import '../utils/app_typography_v2.dart';

/// Nutrition Facts Card
///
/// Displays comprehensive nutrition information:
/// - Calories
/// - Macronutrients (protein, carbs, fat)
/// - Detailed nutrients (fiber, sugar, sodium, etc.)
class NutritionFactsCard extends StatelessWidget {
  final NutritionFacts nutrition;
  final bool isCompact;

  const NutritionFactsCard({
    super.key,
    required this.nutrition,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return _buildCompactView();
    }
    return _buildFullView();
  }

  Widget _buildFullView() {
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
                const Text('📊', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nutrition Facts',
                        style: AppTypographyV2.titleMedium(),
                      ),
                      Text(
                        'Per ${nutrition.servingSize.toStringAsFixed(0)}${nutrition.servingUnit}',
                        style: AppTypographyV2.bodySmall(
                          color: AppColorsV2.slateMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Calories (prominent)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColorsV2.goldenHour.withOpacity(0.2),
              border: Border(
                bottom: BorderSide(
                  color: AppColorsV2.doveGray,
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calories',
                  style: AppTypographyV2.titleSmall(),
                ),
                Text(
                  '${nutrition.calories.toStringAsFixed(0)} kcal',
                  style: AppTypographyV2.numberLarge().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Macronutrients
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Macronutrients',
                  style: AppTypographyV2.labelLarge().copyWith(
                    color: AppColorsV2.slateMuted,
                  ),
                ),
                const SizedBox(height: 12),
                _buildMacroBar(
                  'Protein',
                  '🥩',
                  nutrition.protein,
                  'g',
                  AppColorsV2.mintFresh,
                ),
                const SizedBox(height: 8),
                _buildMacroBar(
                  'Carbohydrates',
                  '🌾',
                  nutrition.carbohydrates,
                  'g',
                  AppColorsV2.goldenHour,
                ),
                const SizedBox(height: 8),
                _buildMacroBar(
                  'Fat',
                  '🥑',
                  nutrition.fat,
                  'g',
                  const Color(0xFFFFD1A3),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            color: AppColorsV2.doveGray,
            height: 1,
            thickness: 1.5,
          ),

          // Detailed Nutrients
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: AppTypographyV2.labelLarge().copyWith(
                    color: AppColorsV2.slateMuted,
                  ),
                ),
                const SizedBox(height: 12),
                _buildNutrientRow('Fiber', nutrition.fiber, 'g'),
                _buildNutrientRow('Sugar', nutrition.sugar, 'g'),
                _buildNutrientRow('Saturated Fat', nutrition.saturatedFat, 'g'),
                _buildNutrientRow('Trans Fat', nutrition.transFat, 'g'),
                _buildNutrientRow('Sodium', nutrition.sodium, 'mg'),
                _buildNutrientRow('Cholesterol', nutrition.cholesterol, 'mg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactView() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColorsV2.snowWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColorsV2.doveGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calories',
                style: AppTypographyV2.labelMedium(),
              ),
              Text(
                '${nutrition.calories.toStringAsFixed(0)} kcal',
                style: AppTypographyV2.numberMedium().copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Macros in chips
          Row(
            children: [
              _buildMacroChip('P', nutrition.protein, AppColorsV2.mintFresh),
              const SizedBox(width: 8),
              _buildMacroChip('C', nutrition.carbohydrates, AppColorsV2.goldenHour),
              const SizedBox(width: 8),
              _buildMacroChip('F', nutrition.fat, const Color(0xFFFFD1A3)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBar(String label, String emoji, double value, String unit, Color color) {
    // Calculate percentage (rough estimate for visual bar)
    double percentage = (value / 100).clamp(0, 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AppTypographyV2.bodyMedium(),
                ),
              ],
            ),
            Text(
              '${value.toStringAsFixed(1)}$unit',
              style: AppTypographyV2.numberMedium().copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Progress bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientRow(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypographyV2.bodyMedium(
              color: AppColorsV2.slateMuted,
            ),
          ),
          Text(
            '${value.toStringAsFixed(1)}$unit',
            style: AppTypographyV2.bodyMedium().copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroChip(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypographyV2.labelSmall(color: color).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${value.toStringAsFixed(0)}g',
            style: AppTypographyV2.labelSmall(color: color),
          ),
        ],
      ),
    );
  }
}
