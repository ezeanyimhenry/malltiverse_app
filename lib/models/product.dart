class Product {
  final String id;
  final String name;
  final String description;
  final String uniqueId;
  final bool isAvailable;
  final double price;
  final String imageUrl;
  final int rating;
  final List<dynamic> categories;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.uniqueId,
    required this.isAvailable,
    this.price = 0.00,
    this.rating = 0,
    this.imageUrl = '',
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> categories = json['categories'] ?? [];
    String imageUrl = '';
    if (json['photos'] != null && json['photos'].isNotEmpty) {
      imageUrl = json['photos'][0]['url'];
      // Check if the URL is relative and make it absolute
      if (!imageUrl.startsWith('http')) {
        imageUrl = 'https://api.timbu.cloud/images/$imageUrl';
      }
    }

// Extract price from current_price field
    double extractedPrice = 0.00;
    if (json.containsKey('current_price')) {
      List<dynamic> currentPrice = json['current_price'];
      if (currentPrice.isNotEmpty) {
        // Assume the first element is the price for simplicity
        dynamic priceValue = currentPrice[0];
        if (priceValue is Map<String, dynamic> &&
            priceValue.containsKey('NGN')) {
          // Assuming NGN is the currency you are interested in
          List<dynamic> ngnValues = priceValue['NGN'];
          if (ngnValues.isNotEmpty && ngnValues[0] is double) {
            extractedPrice = ngnValues[0];
          }
        }
      }
    }

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      uniqueId: json['unique_id'],
      isAvailable: json['is_available'],
      price: extractedPrice,
      rating: 5,
      imageUrl: imageUrl,
      categories: categories,
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
