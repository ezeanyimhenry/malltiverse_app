import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';

class SuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SizedBox(
            width: 200.0,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
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
                        Center(
                          child: Text(
                            'Payment Successful',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                height: 1.22,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                        ),
                        Column(children: [
                          Image.asset('assets/images/check.png'),
                          Center(
                            child: Text(
                              'Payment Successful',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.22,
                                  color: Color(0xFF2A2A2A),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Thanks for your purchase',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  height: 1.22,
                                  color: Color(0xFF2A2A2A),
                                ),
                              ),
                            ),
                          ),
                        ])
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
