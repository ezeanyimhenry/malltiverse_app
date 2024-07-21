import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  final List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  void toggleWishlist(Product product) {
    if (_wishlist.contains(product)) {
      _wishlist.remove(product);
      product.isInWishlist = false;
    } else {
      _wishlist.add(product);
      product.isInWishlist = true;
    }
    notifyListeners();
  }
}
