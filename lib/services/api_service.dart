// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/product.dart';
import '../models/category.dart';

class ApiService {
  final String apiUrl = dotenv.env['TIMBU_BASE_URL']!;
  final String apiKey = dotenv.env['TIMBU_API_KEY'] ?? '';
  final String appId = dotenv.env['TIMBU_APP_ID'] ?? '';
  final String organizationId = dotenv.env['TIMBU_ORGANIZATION_ID'] ?? '';

  Future<List<Category>> fetchCategories() async {
    String jsonItems = '''
  [
    {
      "id": "43ab9137faa843178c5bcb51fc88c903",
      "name": "women's fashion"
    },
    {
      "id": "726c61299381465980dbfddb3446f4b2",
      "name": "gadgets"
    },
    {
      "id": "b396b5718b004a5e801f7e1c776293bd",
      "name": "wrist watches"
    },
    {
      "id": "de0ab5a6ee254e5a99d8297398627677",
      "name": "tech gadgets"
    },
    {
      "id": "edf9e0bc6a834f46b5f14fd148bf85e7",
      "name": "men's fashion"
    }
  ]
  ''';

    // Parse JSON items
    List<dynamic> items = json.decode(jsonItems);
    List<Category> categories =
        items.map((item) => Category.fromJson(item)).toList();
    // print(categories);
    // for (var category in categories) {
    //   print(category.name);
    // }
    return categories;
  }

  // Future<List<Category>> fetchCategories() async {
  //   if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
  //     throw Exception("API Key, App ID, or Organization ID is not set");
  //   }

  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //         "$apiUrl/categories?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey",
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = json.decode(response.body);
  //       List<dynamic> items = jsonResponse['items'];

  //       if (items != null) {
  //         List<Category> categories =
  //             items.map((item) => Category.fromJson(item)).toList();
  //         // print(categories);
  //         return categories;
  //       } else {
  //         throw Exception("API returned null response");
  //       }
  //     } else if (response.statusCode == 403) {
  //       throw Exception("Invalid credentials: ${response.body}");
  //     } else if (response.statusCode == 404) {
  //       throw Exception("Endpoint not found: ${response.body}");
  //     } else {
  //       throw Exception(
  //           "Failed to load categories: ${response.statusCode} - ${response.body}");
  //     }
  //   } catch (e) {
  //     // print("Error during API call: $e");
  //     throw Exception("Failed to load categories");
  //   }
  // }

  Future<List<Product>> fetchProducts({
    int page = 1,
    int size = 10,
    bool reverseSort = false,
  }) async {
    if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
      throw Exception("API Key, App ID, or Organization ID is not set");
    }

    try {
      final response = await http.get(
        Uri.parse(
          "$apiUrl/products?organization_id=$organizationId&reverse_sort=$reverseSort&page=$page&size=$size&Appid=$appId&Apikey=$apiKey",
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic>? items = data['items'];

// Debugging: Print the entire items list
        // print('API items: $items');

        if (items != null) {
          // Debugging: Check each item before parsing
          // items.forEach((item) {
          //   // print('Processing item: $item');
          // });
          List<Product> products = items.map((item) {
            try {
              return Product.fromJson(item);
            } catch (e) {
              // print('Error parsing item: $item');
              // print('Error: $e');
              throw Exception("Failed to parse item: $item");
            }
          }).toList();
          // print(products);
          return products;
        } else {
          throw Exception("API returned null response");
        }
      } else if (response.statusCode == 403) {
        throw Exception("Invalid credentials: ${response.body}");
      } else if (response.statusCode == 404) {
        throw Exception("Endpoint not found: ${response.body}");
      } else {
        throw Exception(
            "Failed to load products: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      // print("Error during API call: $e");
      throw Exception("Failed to load products");
    }
  }

  Future<List<Product>> fetchProductsByCategory({
    required String categoryId,
    int page = 1,
    int size = 10,
    bool reverseSort = false,
  }) async {
    if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
      throw Exception("API Key, App ID, or Organization ID is not set");
    }

    try {
      final response = await http.get(
        Uri.parse(
          "$apiUrl/products?organization_id=$organizationId&category_id=$categoryId&page=$page&size=$size&Appid=$appId&Apikey=$apiKey",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> items = data['items'];

        if (items != null) {
          List<Product> products =
              items.map((item) => Product.fromJson(item)).toList();
          return products;
        } else {
          throw Exception("API returned null response");
        }
      } else if (response.statusCode == 403) {
        throw Exception("Invalid credentials: ${response.body}");
      } else if (response.statusCode == 404) {
        throw Exception("Endpoint not found: ${response.body}");
      } else {
        throw Exception(
            "Failed to load products: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      // print("Error during API call: $e");
      throw Exception("Failed to load products");
    }
  }
}
