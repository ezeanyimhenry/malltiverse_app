import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';
import 'successful_screen.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

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
          'Payment',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Content area
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight,
            child: Consumer<CartProvider>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/Card.png'),
                        SizedBox(height: 34),
                        Text(
                          'Card Number', // Your label text
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              height: 1.22,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: '0000 0000 0000 0000',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(
                                color: Color(0xFF979797),
                                width: 1.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expiry Date', // Your label text
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        height: 1.22,
                                        color: Color(0xFF2A2A2A),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'MM/YY',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF979797),
                                          width: 1.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CVV', // Your label text
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        height: 1.22,
                                        color: Color(0xFF2A2A2A),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: '123',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF979797),
                                          width: 1.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 63),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF7F7D),
                            foregroundColor: Color(0xFF2A2A2A),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            // Implement apply discount code functionality
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuccessfulScreen()),
                            );
                          },
                          child: Text(
                            'Make Payment',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom Navigation Bar
          CustomBottomNavigationBar(
            selectedIndex: 2,
            onItemTapped: (index) {
              if (index == 0) {
                // Navigate to CartScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              } else if (index == 1) {
                // Navigate to CartScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              } else if (index == 2) {
                // Navigate to CheckoutScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              height: 1.22,
              color: Color(0xFF2A2A2A).withOpacity(0.8),
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: Color(0xFF2A2A2A).withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
