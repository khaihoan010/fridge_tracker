import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/food_item.dart';
import '../models/category.dart';
import '../utils/date_utils.dart';
import '../utils/app_colors_v2.dart';
import '../utils/app_typography_v2.dart';
import '../utils/app_spacing_v2.dart';
import '../utils/app_shadows_v2.dart';

/// 🌸 Food Card V2 - Feminine & Modern Design
class FoodCardV2 extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FoodCardV2({
    super.key,
    required this.food,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final category = FoodCategory.getById(food.category);
    final daysLeft = food.daysUntilExpiry;
    final statusColors = AppColorsV2.getStatusColors(daysLeft);
    final statusEmoji = AppColorsV2.getStatusEmoji(daysLeft);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacingV2.l,
        vertical: AppSpacingV2.s,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.4,
          children: [
            // Edit action - Lavender
            SlidableAction(
              onPressed: (_) => onEdit(),
              backgroundColor: AppColorsV2.lavenderMist,
              foregroundColor: AppColorsV2.charcoalSoft,
              icon: Icons.edit_rounded,
              label: 'Sửa',
              borderRadius: AppSpacingV2.borderL,
            ),
            AppSpacingV2.hGapS,
            // Delete action - Coral
            SlidableAction(
              onPressed: (_) => onDelete(),
              backgroundColor: AppColorsV2.coralBlush,
              foregroundColor: AppColorsV2.charcoalSoft,
              icon: Icons.delete_rounded,
              label: 'Xóa',
              borderRadius: AppSpacingV2.borderL,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppSpacingV2.borderXl,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColorsV2.snowWhite,
                    AppColorsV2.pearlGray.withOpacity(0.3),
                  ],
                ),
                borderRadius: AppSpacingV2.borderXl,
                boxShadow: AppShadowsV2.soft,
                border: Border.all(
                  color: AppColorsV2.doveGray.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: AppSpacingV2.paddingL,
                child: Row(
                  children: [
                    // Thumbnail with gradient overlay
                    _buildThumbnail(category),
                    AppSpacingV2.hGapM,

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Food name with emoji
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  food.name,
                                  style: AppTypographyV2.titleSmall(
                                    color: AppColorsV2.charcoalSoft,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              AppSpacingV2.hGapS,
                              // Category emoji
                              Text(
                                _getCategoryEmoji(category.id),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          AppSpacingV2.gapXs,

                          // Category and location row
                          Row(
                            children: [
                              // Category badge
                              _buildInfoChip(
                                icon: Icons.label_rounded,
                                text: category.name,
                                color: AppColorsV2.getCategoryColor(category.id),
                              ),
                              AppSpacingV2.hGapS,
                              // Storage location badge
                              _buildInfoChip(
                                icon: Icons.place_rounded,
                                text: StorageLocation.getById(
                                  food.storageLocation,
                                ).name,
                                color: AppColorsV2.skySoft,
                              ),
                            ],
                          ),
                          AppSpacingV2.gapM,

                          // Expiry date and status
                          Row(
                            children: [
                              // Date with icon
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: AppSpacingV2.iconS,
                                      color: AppColorsV2.slateMuted,
                                    ),
                                    AppSpacingV2.hGapXs,
                                    Text(
                                      AppDateUtils.formatDate(food.expiryDate),
                                      style: AppTypographyV2.bodySmall(
                                        color: AppColorsV2.slateMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Status badge
                              _buildStatusBadge(
                                daysLeft: daysLeft,
                                emoji: statusEmoji,
                                colors: statusColors,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build thumbnail with gradient and rounded corners
  Widget _buildThumbnail(FoodCategory category) {
    final hasImage = food.imagePath != null &&
        File(food.imagePath!).existsSync();

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: AppSpacingV2.borderL,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColorsV2.getCategoryGradient(category.id),
        ),
        boxShadow: AppShadowsV2.getCategoryShadow(category.id),
      ),
      child: ClipRRect(
        borderRadius: AppSpacingV2.borderL,
        child: hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(food.imagePath!),
                    fit: BoxFit.cover,
                  ),
                  // Subtle gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Icon(
                  category.icon,
                  size: AppSpacingV2.iconXl,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  /// Build small info chip
  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacingV2.s,
        vertical: AppSpacingV2.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: AppSpacingV2.borderFull,
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppSpacingV2.iconXs,
            color: color.withOpacity(0.8),
          ),
          AppSpacingV2.hGapXs,
          Text(
            text,
            style: AppTypographyV2.labelSmall(
              color: AppColorsV2.charcoalSoft,
            ),
          ),
        ],
      ),
    );
  }

  /// Build status badge
  Widget _buildStatusBadge({
    required int daysLeft,
    required String emoji,
    required Map<String, Color> colors,
  }) {
    String statusText;
    if (daysLeft < 0) {
      statusText = 'Hết hạn';
    } else if (daysLeft == 0) {
      statusText = 'Hôm nay';
    } else if (daysLeft <= 3) {
      statusText = '$daysLeft ngày';
    } else {
      statusText = '$daysLeft ngày';
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacingV2.m,
        vertical: AppSpacingV2.s,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors['background']!,
            colors['background']!.withOpacity(0.8),
          ],
        ),
        borderRadius: AppSpacingV2.borderFull,
        border: Border.all(
          color: colors['border']!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colors['border']!.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 14),
          ),
          AppSpacingV2.hGapXs,
          Text(
            statusText,
            style: AppTypographyV2.labelMedium(
              color: colors['text']!,
            ),
          ),
        ],
      ),
    );
  }

  /// Get category emoji
  String _getCategoryEmoji(String categoryId) {
    const Map<String, String> emojis = {
      'vegetables': '🥗',
      'fruits': '🍎',
      'meat': '🥩',
      'seafood': '🐟',
      'dairy': '🥛',
      'beverages': '🥤',
      'frozen': '❄️',
      'bakery': '🍞',
      'condiments': '🧂',
      'others': '📦',
    };
    return emojis[categoryId] ?? '📦';
  }
}
