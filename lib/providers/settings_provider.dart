import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../services/notification_service.dart';

class SettingsProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  // Settings
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  int _notifyDaysBefore = AppConstants.defaultNotifyDaysBefore;

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  int get notifyDaysBefore => _notifyDaysBefore;
  bool get isInitialized => _isInitialized;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Initialize settings
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadSettings();
    _isInitialized = true;
    notifyListeners();
  }

  // Load settings từ SharedPreferences
  Future<void> _loadSettings() async {
    _isDarkMode = _prefs.getBool(AppConstants.prefDarkMode) ?? false;
    _notificationsEnabled = _prefs.getBool(AppConstants.prefNotificationsEnabled) ?? true;
    _notifyDaysBefore = _prefs.getInt(AppConstants.prefNotifyDaysBefore) ?? AppConstants.defaultNotifyDaysBefore;
  }

  // Toggle dark mode
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool(AppConstants.prefDarkMode, _isDarkMode);
    notifyListeners();
  }

  // Set dark mode
  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs.setBool(AppConstants.prefDarkMode, _isDarkMode);
    notifyListeners();
  }

  // Toggle notifications
  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    await _prefs.setBool(AppConstants.prefNotificationsEnabled, _notificationsEnabled);

    if (!_notificationsEnabled) {
      // Hủy tất cả thông báo
      await NotificationService.instance.cancelAllNotifications();
    }

    notifyListeners();
  }

  // Set notifications enabled
  Future<void> setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;
    await _prefs.setBool(AppConstants.prefNotificationsEnabled, _notificationsEnabled);

    if (!_notificationsEnabled) {
      await NotificationService.instance.cancelAllNotifications();
    }

    notifyListeners();
  }

  // Set notify days before
  Future<void> setNotifyDaysBefore(int days) async {
    _notifyDaysBefore = days;
    await _prefs.setInt(AppConstants.prefNotifyDaysBefore, _notifyDaysBefore);
    notifyListeners();
  }

  // Reset settings về mặc định
  Future<void> resetSettings() async {
    await setDarkMode(false);
    await setNotificationsEnabled(true);
    await setNotifyDaysBefore(AppConstants.defaultNotifyDaysBefore);
  }

  // Clear all data (reset app)
  Future<void> clearAllData() async {
    await _prefs.clear();
    await _loadSettings();
    notifyListeners();
  }

  // Kiểm tra quyền thông báo
  Future<bool> checkNotificationPermission() async {
    return await NotificationService.instance.hasNotificationPermission();
  }

  // Mở settings thông báo
  Future<void> openNotificationSettings() async {
    await NotificationService.instance.openNotificationSettings();
  }
}
