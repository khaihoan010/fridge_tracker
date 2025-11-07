import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart';

class ExpiryBadge extends StatelessWidget {
  final FoodItem food;
  final bool showIcon;

  const ExpiryBadge({
    super.key,
    required this.food,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final status = food.expiryStatus;
    final days = food.daysUntilExpiry;

    Color badgeColor;
    IconData icon;
    String text;

    switch (status) {
      case ExpiryStatus.expired:
        badgeColor = AppConstants.expiredColor;
        icon = Icons.dangerous;
        text = AppDateUtils.getDaysRemainingText(days);
        break;
      case ExpiryStatus.expiringSoon:
        badgeColor = AppConstants.expiringSoonColor;
        icon = Icons.warning_amber;
        text = AppDateUtils.getDaysRemainingText(days);
        break;
      case ExpiryStatus.fresh:
        badgeColor = AppConstants.freshColor;
        icon = Icons.check_circle;
        text = AppDateUtils.getDaysRemainingText(days);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        border: Border.all(color: badgeColor, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(icon, size: 14, color: badgeColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: badgeColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Large badge cho detail screen
class LargeExpiryBadge extends StatelessWidget {
  final FoodItem food;

  const LargeExpiryBadge({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final status = food.expiryStatus;
    final days = food.daysUntilExpiry;

    Color badgeColor;
    IconData icon;
    String title;
    String subtitle;

    switch (status) {
      case ExpiryStatus.expired:
        badgeColor = AppConstants.expiredColor;
        icon = Icons.dangerous;
        title = 'Đã hết hạn';
        subtitle = days == 0
            ? 'Hôm nay'
            : '${-days} ngày trước';
        break;
      case ExpiryStatus.expiringSoon:
        badgeColor = AppConstants.expiringSoonColor;
        icon = Icons.warning_amber;
        title = 'Sắp hết hạn';
        subtitle = days == 0
            ? 'Hôm nay'
            : days == 1
                ? 'Ngày mai'
                : 'Còn $days ngày';
        break;
      case ExpiryStatus.fresh:
        badgeColor = AppConstants.freshColor;
        icon = Icons.check_circle;
        title = 'Còn hạn';
        subtitle = 'Còn $days ngày';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        border: Border.all(color: badgeColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 48, color: badgeColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
