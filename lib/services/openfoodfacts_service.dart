import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_info.dart';

class OpenFoodFactsService {
  static final OpenFoodFactsService instance = OpenFoodFactsService._init();

  OpenFoodFactsService._init();

  static const String _baseUrl = 'https://world.openfoodfacts.org/api/v2';
  static const String _userAgent = 'FridgeTracker - Android - Version 1.0';

  // Lấy thông tin sản phẩm từ mã vạch
  Future<ProductInfo?> getProductByBarcode(String barcode) async {
    try {
      // Validate barcode format
      if (barcode.isEmpty || barcode == '-1') {
        return null;
      }

      final url = Uri.parse('$_baseUrl/product/$barcode.json');

      final response = await http.get(
        url,
        headers: {
          'User-Agent': _userAgent,
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response('Timeout', 408);
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        // Kiểm tra status
        final status = data['status'] as int?;
        if (status == 1) {
          // Product found
          return ProductInfo.fromJson(data);
        } else {
          // Product not found in database
          return null;
        }
      } else if (response.statusCode == 404) {
        // Product not found
        return null;
      } else {
        // Other errors
        return null;
      }
    } catch (e) {
      // Ignore all errors and return null
      return null;
    }
  }

  // Tìm kiếm sản phẩm theo tên (optional - cho tương lai)
  Future<List<ProductInfo>> searchProducts(String query, {int page = 1}) async {
    try {
      final url = Uri.parse('$_baseUrl/search').replace(queryParameters: {
        'search_terms': query,
        'page': page.toString(),
        'page_size': '20',
        'json': 'true',
      });

      final response = await http.get(
        url,
        headers: {
          'User-Agent': _userAgent,
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final products = data['products'] as List<dynamic>?;

        if (products == null) return [];

        return products
            .map((product) {
              try {
                return ProductInfo.fromJson({
                  'code': product['code'],
                  'product': product,
                });
              } catch (e) {
                print('Error parsing product: $e');
                return null;
              }
            })
            .whereType<ProductInfo>()
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  // Download image từ URL
  Future<List<int>?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {'User-Agent': _userAgent},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }
}
