import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/product.dart';

class ApiService {
  final String apiUrl = "${dotenv.env['TIMBU_BASE_URL']!}products";
  final String apiKey = dotenv.env['TIMBU_API_KEY'] ?? '';
  final String appId = dotenv.env['TIMBU_APP_ID'] ?? '';
  final String organizationId = dotenv.env['TIMBU_ORGANIZATION_ID'] ?? '';

  Future<List<Product>> fetchProducts(
      {int page = 1, int size = 10, bool reverseSort = false}) async {
    // print("API URL: $apiUrl");
    // print("API Key: $apiKey");
    // print("App ID: $appId");
    // print("Organization ID: $organizationId");

    if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
      throw Exception("API Key, App ID, or Organization ID is not set");
    }

    try {
      final response = await http.get(
        Uri.parse(
            "$apiUrl?organization_id=$organizationId&reverse_sort=$reverseSort&page=$page&size=$size&Appid=$appId&Apikey=$apiKey"),
      );

      // print("Response status: ${response.statusCode}");
      // print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> items = data['items'];
        return items.map((item) => Product.fromJson(item)).toList();
      } else if (response.statusCode == 403) {
        throw Exception("Invalid credentials: ${response.body}");
      } else if (response.statusCode == 404) {
        throw Exception("Endpoint not found: ${response.body}");
      } else {
        throw Exception(
            "Failed to load products: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error during API call: $e");
      throw Exception("Failed to load products");
    }
  }

  Future<List<Product>> fetchProductsByCategory({
    required String category,
    int page = 1,
    int size = 10,
    bool reverseSort = false,
  }) async {
    if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
      throw Exception("API Key, App ID, or Organization ID is not set");
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl).replace(queryParameters: {
          'organization_id': organizationId,
          'reverse_sort': reverseSort.toString(),
          'page': page.toString(),
          'size': size.toString(),
          'Appid': appId,
          'Apikey': apiKey,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> items = data['items'];

        // Filter products by category name
        List<Product> filteredProducts = [];
        for (var item in items) {
          List<dynamic> categories = item['categories'];
          for (var categoryInfo in categories) {
            if (categoryInfo['name'].toLowerCase() == category.toLowerCase()) {
              filteredProducts.add(Product.fromJson(item));
              break; // Stop checking other categories for this product
            }
          }
        }

        return filteredProducts;
      } else if (response.statusCode == 403) {
        throw Exception("Invalid credentials: ${response.body}");
      } else if (response.statusCode == 404) {
        throw Exception("Endpoint not found: ${response.body}");
      } else {
        throw Exception(
            "Failed to load products: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error during API call: $e");
      throw Exception("Failed to load products");
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import '../models/product.dart';

// class ApiService {
//   final String apiUrl = dotenv.env['TIMBU_BASE_URL']!;
//   final String apiKey = dotenv.env['TIMBU_API_KEY'] ?? '';
//   final String appId = dotenv.env['TIMBU_APP_ID'] ?? '';
//   final String organizationId = dotenv.env['TIMBU_ORGANIZATION_ID'] ?? '';

//   // Define manually an array of categories
//   List<String> categories = [
//     'Tech Gadgets',
//     'Clothing',
//     'Home Appliances',
//     'Books',
//     'Toys',
//     'Uncategorized', // You can add a default category if needed
//   ];

//   // Fetch all categories
//   Future<List<String>> fetchCategories() async {
//     // Simulate fetching categories from an API
//     // In this case, just return the manually defined categories
//     return categories;
//   }

//   Future<List<Product>> fetchProductsByCategory(String category,
//       {int page = 1, int size = 10}) async {
//     if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
//       throw Exception("API Key, App ID, or Organization ID is not set");
//     }

//     try {
//       String apiUrl = "${dotenv.env['TIMBU_BASE_URL']!}products?";
//       apiUrl += (category.isNotEmpty)
//           ? "category=$category&"
//           : "category=Uncategorized&"; // Default to Uncategorized
//       apiUrl +=
//           "organization_id=$organizationId&page=$page&size=$size&Appid=$appId&Apikey=$apiKey";

//       final response = await http.get(
//         Uri.parse(apiUrl),
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         return data.map((item) => Product.fromJson(item)).toList();
//       } else if (response.statusCode == 403) {
//         throw Exception("Invalid credentials: ${response.body}");
//       } else if (response.statusCode == 404) {
//         throw Exception("Endpoint not found: ${response.body}");
//       } else {
//         throw Exception(
//             "Failed to load products: ${response.statusCode} - ${response.body}");
//       }
//     } catch (e) {
//       print("Error during API call: $e");
//       throw Exception("Failed to load products");
//     }
//   }

//   // Manually encode a list of categories
//   String encodeCategories(List<String> categories) {
//     return json.encode(categories);
//   }
// }
