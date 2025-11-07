import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  static final ImageService instance = ImageService._init();
  final ImagePicker _picker = ImagePicker();

  ImageService._init();

  // Yêu cầu quyền camera
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // Yêu cầu quyền photos
  Future<bool> requestPhotosPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  // Chụp ảnh từ camera
  Future<File?> pickImageFromCamera() async {
    try {
      // Kiểm tra và yêu cầu quyền
      if (!await requestCameraPermission()) {
        print('Camera permission denied');
        return null;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) return null;

      // Lưu ảnh vào thư mục app
      final savedImage = await _saveImage(File(image.path));
      return savedImage;
    } catch (e) {
      print('Error picking image from camera: $e');
      return null;
    }
  }

  // Chọn ảnh từ gallery
  Future<File?> pickImageFromGallery() async {
    try {
      // Kiểm tra và yêu cầu quyền
      if (!await requestPhotosPermission()) {
        print('Photos permission denied');
        return null;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) return null;

      // Lưu ảnh vào thư mục app
      final savedImage = await _saveImage(File(image.path));
      return savedImage;
    } catch (e) {
      print('Error picking image from gallery: $e');
      return null;
    }
  }

  // Hiển thị dialog chọn nguồn ảnh
  Future<File?> pickImage({required ImageSource source}) async {
    if (source == ImageSource.camera) {
      return await pickImageFromCamera();
    } else {
      return await pickImageFromGallery();
    }
  }

  // Lưu ảnh vào thư mục app
  Future<File> _saveImage(File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${appDir.path}/food_images');

    // Tạo thư mục nếu chưa tồn tại
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    // Tạo tên file unique
    final fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';
    final savedImage = File('${imagesDir.path}/$fileName');

    // Copy ảnh
    return await image.copy(savedImage.path);
  }

  // Xóa ảnh
  Future<bool> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting image: $e');
      return false;
    }
  }

  // Lấy file từ path
  File? getImageFile(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;
    final file = File(imagePath);
    return file.existsSync() ? file : null;
  }

  // Xóa tất cả ảnh không sử dụng (cleanup)
  Future<void> cleanupUnusedImages(List<String> usedImagePaths) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/food_images');

      if (!await imagesDir.exists()) return;

      final files = imagesDir.listSync();
      for (var file in files) {
        if (file is File) {
          if (!usedImagePaths.contains(file.path)) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      print('Error cleaning up images: $e');
    }
  }

  // Lấy kích thước ảnh
  Future<int> getImageSize(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      print('Error getting image size: $e');
      return 0;
    }
  }

  // Lấy tổng kích thước tất cả ảnh
  Future<int> getTotalImagesSize() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/food_images');

      if (!await imagesDir.exists()) return 0;

      int totalSize = 0;
      final files = imagesDir.listSync();
      for (var file in files) {
        if (file is File) {
          totalSize += await file.length();
        }
      }
      return totalSize;
    } catch (e) {
      print('Error getting total images size: $e');
      return 0;
    }
  }

  // Format size (bytes to readable format)
  String formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}
