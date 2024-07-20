import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';

import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';

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
          SingleChildScrollView(
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
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
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
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
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
                              width: 1.0, color: Color(0xFFFF7F7D)), // Border
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14.0), // Border radius
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomBottomNavigationBar(
            selectedIndex: 0,
            onItemTapped: (index) {
              if (index == 0) {
                // Navigate to MainScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              } else if (index == 1) {
                // Navigate to CartScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              } else if (index == 2) {
                // Navigate to CheckoutScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckoutScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
