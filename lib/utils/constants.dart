import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Fridge Tracker';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'fridge_tracker.db';
  static const int databaseVersion = 2; // Updated for nutrition features
  static const String tableFoods = 'foods';
  static const String tableNutritionFacts = 'nutrition_facts';
  static const String tableVitaminInfo = 'vitamin_info';
  static const String tableMineralInfo = 'mineral_info';
  static const String tableDailyNutrition = 'daily_nutrition';
  static const String tableUserProfile = 'user_profile';

  // Notification
  static const String notificationChannelId = 'expiry_notifications';
  static const String notificationChannelName = 'Thông báo hết hạn';
  static const String notificationChannelDescription =
      'Nhắc nhở khi thực phẩm sắp hết hạn';

  // Preferences Keys
  static const String prefDarkMode = 'dark_mode';
  static const String prefNotificationsEnabled = 'notifications_enabled';
  static const String prefNotifyDaysBefore = 'notify_days_before';
  static const String prefLanguage = 'language';

  // Default Values
  static const int defaultNotifyDaysBefore = 3;

  // Colors
  static const Color freshColor = Colors.green;
  static const Color expiringSoonColor = Colors.orange;
  static const Color expiredColor = Colors.red;

  // Units
  static const List<String> units = [
    'cái',
    'kg',
    'g',
    'lít',
    'ml',
    'hộp',
    'gói',
    'chai',
    'lon',
    'túi',
  ];

  // Days options for notification
  static const List<int> notificationDaysOptions = [1, 2, 3, 5, 7];
}

// Theme
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
    ),
  );
}
