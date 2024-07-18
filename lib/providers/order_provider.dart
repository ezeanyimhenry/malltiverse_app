import 'package:flutter/foundation.dart';
import 'package:hng_shopping_app_task/models/order.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  // Other methods for managing orders, like fetching from API, deleting, etc.
}
