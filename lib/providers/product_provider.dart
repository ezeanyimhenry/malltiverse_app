import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _cartItems = [];

  List<Product> get products => _products;
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
      notifyListeners();
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


// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../services/api_service.dart';

// class ProductProvider with ChangeNotifier {
//   List<Product> _products = [];
//   List<String> _categories = [];
//   bool _isLoading = false;
//   String? _errorMessage;

//   List<Product> get products => _products;
//   List<String> get categories => _categories;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   Future<void> fetchCategories() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _categories = await ApiService().fetchCategories();
//       _errorMessage = null;
//     } catch (error) {
//       _errorMessage = error.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchProductsByCategory(String category) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _products = await ApiService().fetchProductsByCategory(category);
//       _errorMessage = null;
//     } catch (error) {
//       _errorMessage = error.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Fetch products without category
//   Future<void> fetchUncategorizedProducts() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _products = await ApiService().fetchProductsByCategory('');
//       _errorMessage = null;
//     } catch (error) {
//       _errorMessage = error.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
