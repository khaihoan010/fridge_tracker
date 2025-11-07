# 🚀 Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

## Bước 1: Cài Đặt Flutter

Nếu chưa có Flutter, tải và cài đặt tại: https://docs.flutter.dev/get-started/install

Kiểm tra Flutter đã cài đặt:
```bash
flutter doctor
```

## Bước 2: Cài Đặt Dependencies

```bash
cd fridge_tracker
flutter pub get
```

## Bước 3: Chạy Ứng Dụng

### Trên Android Emulator/Device:
```bash
flutter run
```

### Trên iOS Simulator (chỉ macOS):
```bash
flutter run
```

### Trên Chrome (Web):
```bash
flutter run -d chrome
```

## Bước 4: Build Release

### Android APK:
```bash
flutter build apk --release
```
File APK sẽ được tạo tại: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (khuyến nghị cho Google Play):
```bash
flutter build appbundle --release
```

### iOS (chỉ macOS):
```bash
flutter build ios --release
```

## Lưu Ý Quan Trọng

### Android
- Yêu cầu Android 6.0 (API 23) trở lên
- Cần cấp quyền Camera, Storage, Notifications

### iOS
- Yêu cầu iOS 12.0 trở lên
- Cần cấu hình signing trong Xcode

## Troubleshooting

### Lỗi "Gradle build failed":
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Lỗi permissions:
- Kiểm tra file `android/app/src/main/AndroidManifest.xml`
- Kiểm tra file `ios/Runner/Info.plist`

### Lỗi dependencies:
```bash
flutter clean
rm -rf pubspec.lock
flutter pub get
```

## Hot Reload & Hot Restart

Khi đang chạy app:
- **r** - Hot reload (nhanh, giữ state)
- **R** - Hot restart (chậm hơn, reset state)
- **q** - Quit

## Chạy với profile cụ thể:

```bash
# Debug mode (mặc định)
flutter run

# Profile mode (performance profiling)
flutter run --profile

# Release mode (tối ưu performance)
flutter run --release
```

## VS Code

Install extensions:
- Flutter
- Dart

Chạy app: Press F5 hoặc Run > Start Debugging

## Android Studio

1. Open project folder
2. Click "Run" button
3. Select device/emulator
4. App sẽ được build và chạy

## Cấu Trúc Project

```
fridge_tracker/
├── android/         # Android specific files
├── ios/            # iOS specific files
├── lib/            # Dart source code
│   ├── main.dart   # Entry point
│   ├── models/     # Data models
│   ├── screens/    # UI screens
│   ├── widgets/    # Reusable widgets
│   ├── services/   # Business logic
│   └── utils/      # Utilities
├── pubspec.yaml    # Dependencies
└── README.md       # Documentation
```

## Hỗ Trợ

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra `flutter doctor`
2. Xem logs: `flutter logs`
3. Tạo issue trên GitHub

---

Happy Coding! 🎉
