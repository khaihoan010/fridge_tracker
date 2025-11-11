import 'package:flutter/material.dart';
import '../services/health_score_calculator.dart';
import '../utils/app_colors_v2.dart';
import '../utils/app_typography_v2.dart';

/// Health Score Badge Widget
///
/// Displays a circular badge showing the health score (0-100)
/// Color-coded by rating with emoji indicator
class HealthScoreBadge extends StatelessWidget {
  final HealthScoreResult result;
  final double size;
  final bool showLabel;

  const HealthScoreBadge({
    super.key,
    required this.result,
    this.size = 80,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor(result.rating);
    final emoji = HealthScoreCalculator.getEmoji(result.rating);
    final label = HealthScoreCalculator.getLabel(result.rating);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular badge with score
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.4),
              ],
            ),
            border: Border.all(
              color: color,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emoji
              Text(
                emoji,
                style: TextStyle(fontSize: size * 0.25),
              ),
              SizedBox(height: size * 0.05),
              // Score
              Text(
                '${result.score}',
                style: AppTypographyV2.numberLarge(color: color).copyWith(
                  fontSize: size * 0.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        // Label (optional)
        if (showLabel) ...[
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypographyV2.labelMedium(color: color).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Color _getColor(HealthRating rating) {
    final colorHex = HealthScoreCalculator.getColor(rating);
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }
}

/// Compact Health Score Badge (smaller version)
class CompactHealthScoreBadge extends StatelessWidget {
  final HealthScoreResult result;
  final double size;

  const CompactHealthScoreBadge({
    super.key,
    required this.result,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor(result.rating);
    final emoji = HealthScoreCalculator.getEmoji(result.rating);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Score
          Center(
            child: Text(
              '${result.score}',
              style: AppTypographyV2.labelMedium(color: color).copyWith(
                fontSize: size * 0.35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Emoji in top-right corner
          Positioned(
            top: -2,
            right: -2,
            child: Text(
              emoji,
              style: TextStyle(fontSize: size * 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(HealthRating rating) {
    final colorHex = HealthScoreCalculator.getColor(rating);
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }
}

/// Health Score Card with Details
class HealthScoreCard extends StatelessWidget {
  final HealthScoreResult result;

  const HealthScoreCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor(result.rating);
    final label = HealthScoreCalculator.getLabel(result.rating);
    final labelVi = HealthScoreCalculator.getLabelVi(result.rating);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Badge
          HealthScoreBadge(
            result: result,
            size: 70,
            showLabel: false,
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating
                Text(
                  '$label ($labelVi)',
                  style: AppTypographyV2.titleSmall(color: color).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                // Score breakdown
                Text(
                  'Health Score: ${result.score}/100',
                  style: AppTypographyV2.bodyMedium(
                    color: AppColorsV2.slateMuted,
                  ),
                ),
                const SizedBox(height: 8),
                // Score components
                Row(
                  children: [
                    _buildScoreChip(
                      '+${result.positiveScore.toStringAsFixed(0)}',
                      AppColorsV2.mintFresh,
                    ),
                    const SizedBox(width: 8),
                    _buildScoreChip(
                      '${result.negativeScore.toStringAsFixed(0)}',
                      AppColorsV2.coralBlush,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTypographyV2.labelSmall(color: color).copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getColor(HealthRating rating) {
    final colorHex = HealthScoreCalculator.getColor(rating);
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }
}
