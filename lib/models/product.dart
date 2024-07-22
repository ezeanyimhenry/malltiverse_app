import 'category.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String uniqueId;
  final bool isAvailable;
  final double price;
  double rating;
  final List<Category> categories;
  final List<String> photoUrls;
  bool isInWishlist;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.uniqueId,
    required this.isAvailable,
    this.price = 0.00,
    this.rating = 0.0,
    required this.categories,
    this.photoUrls = const [],
    this.isInWishlist = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var categoryList = json['categories'] as List;
    List<Category> categories =
        categoryList.map((i) => Category.fromJson(i)).toList();

    List<String> photoList = [];
    if (json['photos'] != null && (json['photos'] as List).isNotEmpty) {
      photoList = (json['photos'] as List).map((photo) {
        String urlOfPhotos = photo['url'];
        if (!urlOfPhotos.startsWith('http')) {
          urlOfPhotos = 'https://api.timbu.cloud/images/$urlOfPhotos';
        }
        return urlOfPhotos;
      }).toList();
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
      rating: json['extra_infos']?['rating'] ?? 0.0,
      categories: categories,
      photoUrls: photoList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'unique_id': uniqueId,
      'is_available': isAvailable,
      'price': price,
      'rating': rating,
      'categories': categories.map((category) => category.toJson()).toList(),
      'photos': photoUrls.map((url) => {'url': url}).toList(),
      'is_in_wishlist': isInWishlist,
    };
  }
}

class CartItem {
  final Product product;
  int quantity;
  double price;

  CartItem({required this.product, this.quantity = 1, required this.price});
}
