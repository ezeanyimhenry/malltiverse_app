import 'package:flutter/foundation.dart';
import 'package:hng_shopping_app_task/models/order.dart';

import '../services/api_service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> addOrder(Order order) async {
    // Call your API to save the order
    final newOrder = await ApiService().addOrder(order);
    _orders.add(newOrder);
    notifyListeners();
  }
}
