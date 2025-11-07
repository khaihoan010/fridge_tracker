# 🥗 Fridge Tracker - Quản Lý Thực Phẩm Tủ Lạnh

Ứng dụng quản lý thực phẩm tủ lạnh thông minh, giúp theo dõi hạn sử dụng và giảm lãng phí thực phẩm.

## ✨ Tính Năng Chính

### 📱 Quản Lý Thực Phẩm
- ✅ Thêm/sửa/xóa thực phẩm dễ dàng
- ✅ Phân loại theo danh mục (rau củ, thịt cá, đồ uống, etc.)
- ✅ Quản lý vị trí lưu trữ (tủ lạnh, tủ đông, tủ khô)
- ✅ Theo dõi số lượng và đơn vị

### 📸 Chụp Ảnh & Quét Mã Vạch
- ✅ Chụp ảnh thực phẩm hoặc chọn từ thư viện
- ✅ Quét mã vạch để thêm thông tin nhanh chóng
- ✅ Lưu trữ ảnh tự động

### 🔔 Thông Báo Thông Minh
- ✅ Nhắc nhở khi thực phẩm sắp hết hạn
- ✅ Thông báo khi thực phẩm đã hết hạn
- ✅ Tùy chỉnh thời gian thông báo
- ✅ Bật/tắt thông báo linh hoạt

### 🔍 Tìm Kiếm & Lọc
- ✅ Tìm kiếm thực phẩm theo tên
- ✅ Lọc theo danh mục
- ✅ Lọc theo vị trí lưu trữ
- ✅ Phân loại theo trạng thái (còn hạn, sắp hết, đã hết hạn)

### 🎨 Giao Diện Đẹp Mắt
- ✅ Material Design 3
- ✅ Dark Mode / Light Mode
- ✅ Responsive design
- ✅ Animations mượt mà

## 🚀 Bắt Đầu

### Yêu Cầu
- Flutter SDK 3.8+
- Dart SDK 3.0+
- Android 6.0+ / iOS 12.0+

### Cài Đặt

```bash
# Clone repository
cd fridge_tracker

# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

## 📦 Thư Viện Sử Dụng

- **sqflite** - SQLite database
- **provider** - State management
- **flutter_barcode_scanner** - Quét mã vạch
- **image_picker** - Chụp/chọn ảnh
- **flutter_local_notifications** - Thông báo
- **google_fonts** - Custom fonts

## 🏗️ Kiến Trúc

```
lib/
├── models/          # Data models
├── database/        # SQLite database
├── providers/       # State management
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── services/        # Business logic
└── utils/          # Utilities
```

## 📖 Hướng Dẫn Sử Dụng

1. **Thêm thực phẩm:** Nhấn nút "+" → Nhập thông tin → Lưu
2. **Chỉnh sửa:** Vuốt sang phải → Chọn "Sửa"
3. **Xóa:** Vuốt sang phải → Chọn "Xóa"
4. **Tìm kiếm:** Dùng thanh tìm kiếm ở trên
5. **Lọc:** Chọn tab hoặc danh mục

## 🎯 Roadmap

- [ ] Gợi ý công thức nấu ăn
- [ ] Danh sách mua sắm
- [ ] Thống kê chi tiết
- [ ] Backup Cloud
- [ ] Widget Home Screen

## 📄 License

MIT License - Xem file LICENSE

---

⭐ **Nếu project hữu ích, hãy cho một star!** ⭐
