import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_shadows.dart';

enum BadgeType { fresh, warning, expired }

class CuteBadge extends StatelessWidget {
  final BadgeType type;
  final String? customText;

  const CuteBadge({
    super.key,
    required this.type,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    final data = _getBadgeData(type);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundNeu,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        boxShadow: AppShadows.neuSoft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data.emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            customText ?? data.text,
            style: AppTypography.labelSmall.copyWith(
              color: data.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeData _getBadgeData(BadgeType type) {
    switch (type) {
      case BadgeType.fresh:
        return _BadgeData(
          color: AppColors.statusFresh,
          emoji: '✨',
          text: 'Tươi',
        );
      case BadgeType.warning:
        return _BadgeData(
          color: AppColors.statusWarning,
          emoji: '⏰',
          text: 'Sắp hết',
        );
      case BadgeType.expired:
        return _BadgeData(
          color: AppColors.statusExpired,
          emoji: '😢',
          text: 'Hết hạn',
        );
    }
  }
}

class _BadgeData {
  final Color color;
  final String emoji;
  final String text;

  _BadgeData({
    required this.color,
    required this.emoji,
    required this.text,
  });
}
