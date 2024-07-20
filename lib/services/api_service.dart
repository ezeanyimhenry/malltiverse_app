// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
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

  Future<Product> fetchProductById(String productId) async {
    final response = await http.get(
      Uri.parse(
        "$apiUrl/products/$productId?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey",
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Safely handle `double` and `List<dynamic>`
      double price = (data['price'] is double) ? data['price'] as double : 0.0;

      var categoryList = data['categories'] as List;
      List<Category> categories =
          categoryList.map((i) => Category.fromJson(i)).toList();

      List<String> photoList = [];
      if (data['photos'] != null && (data['photos'] as List).isNotEmpty) {
        photoList = (data['photos'] as List).map((photo) {
          String urlOfPhotos = photo['url'];
          if (!urlOfPhotos.startsWith('http')) {
            urlOfPhotos = 'https://api.timbu.cloud/images/$urlOfPhotos';
          }
          return urlOfPhotos;
        }).toList();
      }

      // Create and return the Product object
      return Product(
        id: data['id'] as String,
        uniqueId: data['unique_id'] as String,
        isAvailable: true,
        name: data['name'] as String,
        description: data['description'] as String,
        price: price,
        photoUrls: photoList,
        categories: categories,
      );
    } else if (response.statusCode == 403) {
      throw Exception("Invalid credentials: ${response.body}");
    } else if (response.statusCode == 404) {
      throw Exception("Endpoint not found: ${response.body}");
    } else {
      throw Exception(
          "Failed to load products: ${response.statusCode} - ${response.body}");
    }
  }

  Future<Order> addOrder(Order order) async {
    // Generate a unique ID for the order
    var uuid = const Uuid();
    String uniqueOrderId = uuid.v4();

    // Uncomment the following lines to simulate a delay if needed
    // await Future.delayed(Duration(seconds: 1));

    // Construct the response data using the passed parameters
    final responseData = {
      'id': uniqueOrderId, // Use the generated unique ID
      'deliveryAddress': order
          .deliveryAddress, // Use the delivery address from the passed order
      'items': order.orderItems
          .map((item) => {
                'productId': item.productId,
                'quantity': item.quantity,
                'price': item.price,
              })
          .toList(),
      'orderDate': DateTime.now()
          .toIso8601String(), // Use the current date/time as the order date
    };

    // Create and return the Order object
    return Order(
      id: responseData['id'] as String,
      deliveryAddress: responseData['deliveryAddress'] as String,
      orderItems: (responseData['items'] as List)
          .map((item) => OrderItem(
                productId: item['productId'],
                quantity: item['quantity'],
                price: item['price'],
              ))
          .toList(),
      orderDate: DateTime.parse(responseData['orderDate'] as String),
    );
  }

  // Future<Order> addOrder(Order order) async {
  //   final url = Uri.parse('$apiUrl/sales?Appid=$appId&Apikey=$apiKey');
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'organization_id': organizationId,
  //       'currency_code': 'NGN',
  //       // 'deliveryAddress': order.deliveryAddress,
  //       'products_sold': order.orderItems
  //           .map((item) => {
  //                 'productId': item.productId,
  //                 "amount": item.price,
  //                 'quantity': item.quantity,
  //                 "discount": 0,
  //                 "currency_code": "NGN"
  //               })
  //           .toList(),
  //       // 'orderDate': order.orderDate.toIso8601String(),
  //       'customer_title': 'Mr',
  //       'first_name': 'Matthew',
  //       'last_name': 'James',
  //       'email': 'Matthewjames@email.com',
  //       'phone': 865378490,
  //       'country_code': '+234',
  //       'mode_of_payment': 'bank transfer',
  //       'sales_status': 'pending',
  //       'description': 'Sold a brown shoe to Mr Matthew'
  //     }),
  //   );
  //   if (response.statusCode == 201) {
  //     final responseData = json.decode(response.body);
  //     return Order(
  //       id: responseData['id'],
  //       deliveryAddress: responseData['deliveryAddress'],
  //       orderItems: (responseData['items'] as List)
  //           .map((item) => OrderItem(
  //                 productId: item['productId'],
  //                 quantity: item['quantity'],
  //                 price: item['price'],
  //               ))
  //           .toList(),
  //       orderDate: DateTime.parse(responseData['orderDate']),
  //     );
  //   } else {
  //     final errorResponse = json.decode(response.body);
  //     print(errorResponse);
  //     final errorMessage = errorResponse['message'] ?? 'Failed to add order';
  //     throw Exception(errorMessage);
  //   }
  // }
}
