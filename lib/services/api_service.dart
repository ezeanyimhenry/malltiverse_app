// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/category.dart';

class ApiService {
  final String apiUrl = dotenv.env['TIMBU_BASE_URL']!;
  final String apiKey = dotenv.env['TIMBU_API_KEY'] ?? '';
  final String appId = dotenv.env['TIMBU_APP_ID'] ?? '';
  final String organizationId = dotenv.env['TIMBU_ORGANIZATION_ID'] ?? '';

  Future<List<Category>> fetchCategories() async {
    if (apiKey.isEmpty || appId.isEmpty || organizationId.isEmpty) {
      throw Exception("API Key, App ID, or Organization ID is not set");
    }

    try {
      final response = await http.get(
        Uri.parse(
          "$apiUrl/categories?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> items = jsonResponse['items'];

        if (items != null) {
          List<Category> categories =
              items.map((item) => Category.fromJson(item)).toList();
          // print(categories);
          return categories;
        } else {
          throw Exception("API returned null response");
        }
      } else if (response.statusCode == 403) {
        throw Exception("Invalid credentials: ${response.body}");
      } else if (response.statusCode == 404) {
        throw Exception("Endpoint not found: ${response.body}");
      } else {
        throw Exception(
            "Failed to load categories: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      // print("Error during API call: $e");
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Product>> fetchProducts({
    int page = 1,
    int size = 50,
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

        if (items != null) {
          List<Product> products = items.map((item) {
            try {
              return Product.fromJson(item);
            } catch (e) {
              throw Exception("Failed to parse item: $item");
            }
          }).toList();

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
    int size = 50,
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
        print(items);
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

  Future<Order> addOrder(Order order) async {
    final url = Uri.parse('$apiUrl/sales?Appid=$appId&Apikey=$apiKey');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'organization_id': organizationId,
        'currency_code': 'NGN',
        // 'deliveryAddress': order.deliveryAddress,
        'products_sold': order.orderItems
            .map((item) => {
                  'productId': item.productId,
                  "amount": item.price,
                  'quantity': item.quantity,
                  "discount": 0,
                  "currency_code": "NGN"
                })
            .toList(),
        // 'orderDate': order.orderDate.toIso8601String(),
        'customer_title': 'Mr',
        'first_name': 'Matthew',
        'last_name': 'James',
        'email': 'Matthewjames@email.com',
        'phone': 865378490,
        'country_code': '+234',
        'mode_of_payment': 'bank transfer',
        'sales_status': 'pending',
        'description': 'Sold a brown shoe to Mr Matthew'
      }),
    );
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return Order(
        id: responseData['id'],
        deliveryAddress: responseData['deliveryAddress'],
        orderItems: (responseData['items'] as List)
            .map((item) => OrderItem(
                  productId: item['productId'],
                  quantity: item['quantity'],
                  price: item['price'],
                ))
            .toList(),
        orderDate: DateTime.parse(responseData['orderDate']),
      );
    } else {
      final errorResponse = json.decode(response.body);
      print(errorResponse);
      final errorMessage = errorResponse['message'] ?? 'Failed to add order';
      throw Exception(errorMessage);
    }
  }
}
