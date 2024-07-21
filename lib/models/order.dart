class Order {
  final String id;
  final String deliveryAddress;
  final String phone1;
  final String phone2;
  final List<OrderItem> orderItems;
  final DateTime orderDate;

  Order({
    required this.id,
    this.deliveryAddress = '',
    this.phone1 = '',
    this.phone2 = '',
    required this.orderItems,
    required this.orderDate,
  });

  // factory Order.fromJson(Map<String, dynamic> json) {
  //   return Order(
  //     id: json['id'],
  //     deliveryAddress: json['deliveryAddress'],
  //     items: (json['products'] as List)
  //         .map((productJson) => Product.fromJson(productJson))
  //         .toList(),
  //       cartItems: (json['products'] as List).map((productJson) => CartItem.fromJson(productJson))
  //         .toList()
  //     createdAt: DateTime.parse(json['created_at']),
  //   );
  // }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });
}
