import 'package:flutter/material.dart';
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

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ApiService().fetchProducts();
      _errorMessage = null;
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
    // print("Filtering products by category: $filteredCategory");
    return filteredCategory;
  }

  List<Product> getCategoryProducts(categoryName) {
    return filterProductsByCategory(categoryName);
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await ApiService().fetchCategories();

      // for (var category in _categories) {
      //   print(category.name);
      // }
      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      await Future.microtask(() {
        notifyListeners(); // Notify listeners after state changes
      });
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      _products =
          await ApiService().fetchProductsByCategory(categoryId: category);
      _errorMessage = null; // Reset error message if successful
    } catch (error) {
      _errorMessage = error.toString(); // Capture error message
    } finally {
      _isLoading = false; // Mark loading as complete
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
}
