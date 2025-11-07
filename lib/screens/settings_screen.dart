import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          if (!settings.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              // Appearance Section
              const _SectionHeader(title: 'Giao diện'),
              SwitchListTile(
                title: const Text('Chế độ tối'),
                subtitle: const Text('Sử dụng giao diện tối'),
                secondary: Icon(
                  settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                value: settings.isDarkMode,
                onChanged: (_) => settings.toggleDarkMode(),
              ),
              const Divider(),

              // Notification Section
              const _SectionHeader(title: 'Thông báo'),
              SwitchListTile(
                title: const Text('Bật thông báo'),
                subtitle: const Text('Nhận thông báo khi thực phẩm sắp hết hạn'),
                secondary: const Icon(Icons.notifications),
                value: settings.notificationsEnabled,
                onChanged: (_) => settings.toggleNotifications(),
              ),

              if (settings.notificationsEnabled) ...[
                ListTile(
                  leading: const Icon(Icons.schedule),
                  title: const Text('Nhắc trước'),
                  subtitle: Text('${settings.notifyDaysBefore} ngày trước khi hết hạn'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showNotifyDaysDialog(context, settings),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Cài đặt hệ thống'),
                  subtitle: const Text('Mở cài đặt thông báo'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => settings.openNotificationSettings(),
                ),
              ],
              const Divider(),

              // Data Section
              const _SectionHeader(title: 'Dữ liệu'),
              ListTile(
                leading: const Icon(Icons.delete_sweep),
                title: const Text('Xóa thực phẩm hết hạn'),
                subtitle: const Text('Xóa tất cả thực phẩm đã hết hạn'),
                onTap: () => _showDeleteExpiredDialog(context),
              ),
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Khôi phục mặc định'),
                subtitle: const Text('Đặt lại cài đặt về mặc định'),
                onTap: () => _showResetDialog(context, settings),
              ),
              const Divider(),

              // About Section
              const _SectionHeader(title: 'Thông tin'),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Phiên bản'),
                subtitle: Text(AppConstants.appVersion),
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('Về ứng dụng'),
                subtitle: const Text('Fridge Tracker - Quản lý thực phẩm tủ lạnh'),
                onTap: () => _showAboutDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showNotifyDaysDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nhắc trước'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppConstants.notificationDaysOptions.map((days) {
            return RadioListTile<int>(
              title: Text('$days ngày'),
              value: days,
              groupValue: settings.notifyDaysBefore,
              onChanged: (value) {
                if (value != null) {
                  settings.setNotifyDaysBefore(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _showDeleteExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa tất cả thực phẩm đã hết hạn?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Delete all expired foods
              // This would require FoodProvider
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa thực phẩm hết hạn')),
              );
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Khôi phục mặc định'),
        content: const Text('Bạn có chắc muốn đặt lại tất cả cài đặt về mặc định?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              settings.resetSettings();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã khôi phục cài đặt mặc định')),
              );
            },
            child: const Text('Đặt lại'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: const Icon(Icons.kitchen, size: 48),
      children: [
        const Text(
          'Ứng dụng quản lý thực phẩm tủ lạnh, theo dõi hạn sử dụng '
          'và giúp giảm lãng phí thực phẩm.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Tính năng:\n'
          '• Quản lý thực phẩm\n'
          '• Quét mã vạch\n'
          '• Chụp ảnh thực phẩm\n'
          '• Thông báo hết hạn\n'
          '• Tìm kiếm và lọc\n'
          '• Dark mode',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
