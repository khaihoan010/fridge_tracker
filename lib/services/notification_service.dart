import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._init();
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  NotificationService._init();

  // Khởi tạo notification service
  Future<void> initialize() async {
    // Khởi tạo timezone
    tz.initializeTimeZones();

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Tạo notification channel cho Android
    await _createNotificationChannel();

    // Yêu cầu quyền thông báo
    await _requestPermissions();
  }

  // Tạo notification channel cho Android
  Future<void> _createNotificationChannel() async {
    const androidChannel = AndroidNotificationChannel(
      AppConstants.notificationChannelId,
      AppConstants.notificationChannelName,
      description: AppConstants.notificationChannelDescription,
      importance: Importance.high,
      playSound: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  // Yêu cầu quyền thông báo
  Future<bool> _requestPermissions() async {
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true;
  }

  // Xử lý khi tap vào notification
  void _onNotificationTapped(NotificationResponse response) {
    // TODO: Navigate to food detail screen
    print('Notification tapped: ${response.payload}');
  }

  // Lên lịch thông báo cho thực phẩm sắp hết hạn
  Future<void> scheduleFoodExpiryNotification(
    FoodItem food,
    int daysBeforeExpiry,
  ) async {
    if (food.id == null) return;

    final notificationTime = food.expiryDate.subtract(
      Duration(days: daysBeforeExpiry),
    );
    final now = DateTime.now();

    // Chỉ lên lịch nếu thời gian thông báo chưa qua
    if (notificationTime.isAfter(now)) {
      final scheduledDate = tz.TZDateTime.from(notificationTime, tz.local);

      await _notifications.zonedSchedule(
        food.id!,
        'Thực phẩm sắp hết hạn!',
        '${food.name} sẽ hết hạn sau $daysBeforeExpiry ngày',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.notificationChannelId,
            AppConstants.notificationChannelName,
            channelDescription: AppConstants.notificationChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: food.id.toString(),
      );
    }
  }

  // Hiển thị thông báo ngay lập tức
  Future<void> showImmediateNotification(
    int id,
    String title,
    String body, {
    String? payload,
  }) async {
    await _notifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          AppConstants.notificationChannelId,
          AppConstants.notificationChannelName,
          channelDescription: AppConstants.notificationChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  // Hủy thông báo theo ID
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // Hủy tất cả thông báo
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Lên lịch thông báo hàng ngày để kiểm tra thực phẩm hết hạn
  Future<void> scheduleDailyExpiryCheck() async {
    // Lên lịch thông báo vào 9h sáng mỗi ngày
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, 9, 0);

    // Nếu 9h sáng hôm nay đã qua, lên lịch cho ngày mai
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    await _notifications.zonedSchedule(
      999999, // ID đặc biệt cho daily check
      'Fridge Tracker',
      'Nhớ kiểm tra thực phẩm trong tủ lạnh nhé!',
      tzScheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          AppConstants.notificationChannelId,
          AppConstants.notificationChannelName,
          channelDescription: AppConstants.notificationChannelDescription,
          importance: Importance.defaultImportance,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // Lặp lại hàng ngày
    );
  }

  // Lấy danh sách pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  // Kiểm tra quyền thông báo
  Future<bool> hasNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  // Mở cài đặt thông báo
  Future<void> openNotificationSettings() async {
    await openAppSettings();
  }
}
