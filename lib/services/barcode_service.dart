import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/product_info.dart';
import 'openfoodfacts_service.dart';

class BarcodeService {
  static final BarcodeService instance = BarcodeService._init();

  BarcodeService._init();

  // Quét mã vạch
  Future<String?> scanBarcode(BuildContext context) async {
    return await _showBarcodeScanner(context, const [BarcodeFormat.all]);
  }

  // Quét QR code
  Future<String?> scanQRCode(BuildContext context) async {
    return await _showBarcodeScanner(context, const [BarcodeFormat.qrCode]);
  }

  // Quét mã vạch và lấy thông tin sản phẩm
  Future<Map<String, dynamic>> scanAndGetProductInfo(BuildContext context) async {
    final barcode = await scanBarcode(context);
    if (barcode == null) {
      return {'barcode': null, 'productInfo': null};
    }

    // Hiển thị loading
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    try {
      final productInfo = await OpenFoodFactsService.instance.getProductByBarcode(barcode);
      return {'barcode': barcode, 'productInfo': productInfo};
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop(); // Đóng loading dialog
      }
    }
  }

  // Hiển thị scanner screen
  Future<String?> _showBarcodeScanner(
    BuildContext context,
    List<BarcodeFormat> formats,
  ) async {
    return await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => _BarcodeScannerScreen(formats: formats),
      ),
    );
  }

  // Validate barcode format
  bool isValidBarcode(String barcode) {
    // Kiểm tra barcode có độ dài hợp lệ
    // EAN-13: 13 chữ số
    // EAN-8: 8 chữ số
    // UPC-A: 12 chữ số
    final validLengths = [8, 12, 13];

    if (!validLengths.contains(barcode.length)) {
      return false;
    }

    // Kiểm tra chỉ chứa số
    return RegExp(r'^\d+$').hasMatch(barcode);
  }

  // Format barcode để hiển thị
  String formatBarcode(String barcode) {
    if (barcode.length == 13) {
      // EAN-13: xxx-xxxx-xxxxx-x
      return '${barcode.substring(0, 3)}-${barcode.substring(3, 7)}-${barcode.substring(7, 12)}-${barcode.substring(12)}';
    } else if (barcode.length == 12) {
      // UPC-A: xxx-xxx-xxx-xxx
      return '${barcode.substring(0, 3)}-${barcode.substring(3, 6)}-${barcode.substring(6, 9)}-${barcode.substring(9)}';
    } else if (barcode.length == 8) {
      // EAN-8: xxxx-xxxx
      return '${barcode.substring(0, 4)}-${barcode.substring(4)}';
    }
    return barcode;
  }
}

// Scanner Screen Widget
class _BarcodeScannerScreen extends StatefulWidget {
  final List<BarcodeFormat> formats;

  const _BarcodeScannerScreen({required this.formats});

  @override
  State<_BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<_BarcodeScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBarcodeDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final String? code = barcode.rawValue;

    if (code != null && code.isNotEmpty) {
      setState(() => _isProcessing = true);
      Navigator.pop(context, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét mã'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onBarcodeDetect,
          ),
          // Overlay với khung quét
          CustomPaint(
            painter: _ScannerOverlay(),
            child: Container(),
          ),
          // Hướng dẫn
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Đặt mã vạch vào trong khung',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter cho overlay
class _ScannerOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double scanAreaWidth = size.width * 0.7;
    final double scanAreaHeight = size.height * 0.3;
    final double left = (size.width - scanAreaWidth) / 2;
    final double top = (size.height - scanAreaHeight) / 2;

    // Vẽ overlay tối xung quanh
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final scanAreaPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, scanAreaWidth, scanAreaHeight),
          const Radius.circular(12),
        ),
      );

    final overlayPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      scanAreaPath,
    );

    canvas.drawPath(
      overlayPath,
      Paint()..color = Colors.black.withOpacity(0.5),
    );

    // Vẽ viền khung quét
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, scanAreaWidth, scanAreaHeight),
        const Radius.circular(12),
      ),
      borderPaint,
    );

    // Vẽ các góc
    final cornerPaint = Paint()
      ..color = const Color(0xff6666)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    const cornerLength = 30.0;

    // Góc trên trái
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top), cornerPaint);
    canvas.drawLine(Offset(left, top), Offset(left, top + cornerLength), cornerPaint);

    // Góc trên phải
    canvas.drawLine(Offset(left + scanAreaWidth, top),
        Offset(left + scanAreaWidth - cornerLength, top), cornerPaint);
    canvas.drawLine(Offset(left + scanAreaWidth, top),
        Offset(left + scanAreaWidth, top + cornerLength), cornerPaint);

    // Góc dưới trái
    canvas.drawLine(Offset(left, top + scanAreaHeight),
        Offset(left + cornerLength, top + scanAreaHeight), cornerPaint);
    canvas.drawLine(Offset(left, top + scanAreaHeight),
        Offset(left, top + scanAreaHeight - cornerLength), cornerPaint);

    // Góc dưới phải
    canvas.drawLine(Offset(left + scanAreaWidth, top + scanAreaHeight),
        Offset(left + scanAreaWidth - cornerLength, top + scanAreaHeight), cornerPaint);
    canvas.drawLine(Offset(left + scanAreaWidth, top + scanAreaHeight),
        Offset(left + scanAreaWidth, top + scanAreaHeight - cornerLength), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
