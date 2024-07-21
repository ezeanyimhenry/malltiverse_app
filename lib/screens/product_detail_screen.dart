import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';

import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Format price with commas for thousands separators and two decimal places
    final priceFormat = NumberFormat.currency(locale: 'en_NG', symbol: '₦');
    String formattedPrice = priceFormat.format(product.price);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: 200.0,
              child: Image.asset(
                'assets/images/arrow-left.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: Text(
          'Product Details', // Update the title based on selected index
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: NetworkImage(product.photoUrls[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        if (product.photoUrls.length > 1)
                          SizedBox(
                            height: 100.0,
                            child: PageView.builder(
                              itemCount: (product.photoUrls.length / 5).ceil(),
                              itemBuilder: (context, pageIndex) {
                                int startIndex = pageIndex * 5;
                                int endIndex = startIndex + 5;
                                endIndex = endIndex > product.photoUrls.length
                                    ? product.photoUrls.length
                                    : endIndex;

                                List<String> photosForPage = product.photoUrls
                                    .sublist(startIndex, endIndex);

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: photosForPage
                                      .map((photoUrl) => Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(photoUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              height: 180.0,
                                            ),
                                          ))
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 20.0),
                        Text(
                          product.name,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          formattedPrice,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              color: Color(0xFFFF7F7D),
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 14.0,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addItem(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to cart!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    width: 1.0,
                                    color: Color(0xFFFF7F7D)), // Border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      14.0), // Border radius
                                ),
                              ),
                              child: Text(
                                'Add to Cart',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0,
                                    height: 1.22,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Consumer<WishlistProvider>(
                                builder: (context, wishlistProvider, child) {
                                  bool isInWishlist = wishlistProvider.wishlist
                                      .contains(product);
                                  return GestureDetector(
                                    onTap: () {
                                      wishlistProvider.toggleWishlist(product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        isInWishlist
                                            ? const SnackBar(
                                                content: Text(
                                                    'Removed from Wishlist!'),
                                                duration: Duration(seconds: 1),
                                              )
                                            : const SnackBar(
                                                content:
                                                    Text('Added to Wishlist!'),
                                                duration: Duration(seconds: 1),
                                              ),
                                      );
                                    },
                                    child: Icon(
                                      isInWishlist
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Color(0xFFFF7F7D),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CustomBottomNavigationBar(
            selectedIndex: 0,
          ),
        ],
      ),
    );
  }
}
