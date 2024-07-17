import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_shopping_app_task/screens/payment_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'main_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedPickup;

  @override
  void initState() {
    super.initState();
    // Set the default selected value
    _selectedPickup =
        'Sokoto Street, Area 1, Garki Area 1 AMAC'; // Default selected gender
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 120,
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
        title: Text(
          'Checkout',
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
                if (provider.items.isEmpty) {
                  return Center(
                    child: Text(
                      "No items to checkout",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                          height: 1.22, // Calculated as 14.63 / 12.0
                        ),
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Select how to receive your package(s)',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Pickup',
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
                            height: 12,
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                activeColor: Color(0xFFFF7F7D),
                                value:
                                    'Old Secretariat Complex, Area 1, Garki Abaji Abji',
                                groupValue: _selectedPickup,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPickup = value;
                                  });
                                },
                              ),
                              Text(
                                'Old Secretariat Complex, Area 1, Garki Abaji Abji',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    height: 1.22,
                                    color: Color(0xFF2A2A2A).withOpacity(0.67),
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Radio<String>(
                                activeColor: Color(0xFFFF7F7D),
                                value:
                                    'Sokoto Street, Area 1, Garki Area 1 AMAC',
                                groupValue: _selectedPickup,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPickup = value;
                                  });
                                },
                              ),
                              Text(
                                'Sokoto Street, Area 1, Garki Area 1 AMAC',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    height: 1.22,
                                    color: Color(0xFF2A2A2A).withOpacity(0.67),
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Delivery', // Your label text
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                                color: Color(0xFF2A2A2A).withOpacity(0.63),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF2A2A2A).withOpacity(0.7),
                                  width: 1.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Contact', // Your label text
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                                color: Color(0xFF2A2A2A).withOpacity(0.63),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'phone nos 1',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF2A2A2A).withOpacity(0.7),
                                  width: 1.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'phone nos 2',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF2A2A2A).withOpacity(0.7),
                                  width: 1.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
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
                                    builder: (context) => PaymentScreen()),
                              );
                            },
                            child: Text(
                              'Go to Payment',
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
                }
              },
            ),
          ),
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
          )
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
