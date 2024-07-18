import 'product.dart';

class Order {
  final int id;
  final List<Product> products;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.products,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
