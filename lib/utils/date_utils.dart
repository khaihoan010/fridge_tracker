import 'package:intl/intl.dart';

class AppDateUtils {
  // Format ngày theo định dạng dd/MM/yyyy
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Format ngày giờ theo định dạng dd/MM/yyyy HH:mm
  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  // Format ngày theo định dạng tương đối (Hôm nay, Ngày mai, etc.)
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    final difference = targetDate.difference(today).inDays;

    if (difference == 0) {
      return 'Hôm nay';
    } else if (difference == 1) {
      return 'Ngày mai';
    } else if (difference == -1) {
      return 'Hôm qua';
    } else if (difference > 1 && difference <= 7) {
      return 'Còn $difference ngày';
    } else if (difference < -1 && difference >= -7) {
      return '${-difference} ngày trước';
    } else {
      return formatDate(date);
    }
  }

  // Tính số ngày còn lại
  static int daysUntil(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    return targetDate.difference(today).inDays;
  }

  // Lấy văn bản mô tả số ngày còn lại
  static String getDaysRemainingText(int days) {
    if (days < 0) {
      return 'Hết hạn ${-days} ngày trước';
    } else if (days == 0) {
      return 'Hết hạn hôm nay';
    } else if (days == 1) {
      return 'Hết hạn ngày mai';
    } else {
      return 'Còn $days ngày';
    }
  }

  // Kiểm tra xem có phải hôm nay không
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  // Kiểm tra xem có phải ngày mai không
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
           date.month == tomorrow.month &&
           date.day == tomorrow.day;
  }

  // Lấy ngày bắt đầu của tuần
  static DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Lấy ngày kết thúc của tuần
  static DateTime getEndOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  // Parse string thành DateTime
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // Lấy ngày bắt đầu của tháng
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  // Lấy ngày kết thúc của tháng
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }
}
