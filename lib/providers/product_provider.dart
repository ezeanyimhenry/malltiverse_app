import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  List<Product> filteredCategory = [];
  bool _isLoading = false;
  String? _errorMessage;
  final List<Product> _cartItems = [];

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Product> get cartItems => _cartItems;

  ProductProvider() {
    loadCachedData();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // _errorMessage = "No internet connection. Loading cached data.";
        loadCachedData();
      } else {
        _products = await ApiService().fetchProducts();
        _errorMessage = null;
        await cacheProducts();
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      await Future.microtask(() {
        notifyListeners(); // Notify listeners after state changes
      });
    }
  }

  List<Product> filterProductsByCategory(String categoryName) {
    List<Product> filteredCategory = _products.where((product) {
      return product.categories
          .any((category) => category.name == categoryName);
    }).toList();
    return filteredCategory;
  }

  List<Product> getCategoryProducts(String categoryName) {
    return filterProductsByCategory(categoryName);
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // _errorMessage = "No internet connection. Loading cached data.";
        loadCachedData();
      } else {
        _categories = await ApiService().fetchCategories();
        _errorMessage = null;
        await cacheCategories();
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      await Future.microtask(() {
        notifyListeners(); // Notify listeners after state changes
      });
    }
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  Future<void> cacheProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productsJson =
        _products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList('cachedProducts', productsJson);
  }

  Future<void> cacheCategories() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson =
        _categories.map((category) => jsonEncode(category.toJson())).toList();
    await prefs.setStringList('cachedCategories', categoriesJson);
  }

  Future<void> loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load cached products
    List<String>? productsJson = prefs.getStringList('cachedProducts');
    if (productsJson != null) {
      _products = productsJson
          .map((productJson) => Product.fromJson(jsonDecode(productJson)))
          .toList();
    }

    // Load cached categories
    List<String>? categoriesJson = prefs.getStringList('cachedCategories');
    if (categoriesJson != null) {
      _categories = categoriesJson
          .map((categoryJson) => Category.fromJson(jsonDecode(categoryJson)))
          .toList();
    }

    notifyListeners();
  }
}
