import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

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
        title: Text(
          'Cart',
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
                      "No items in cart",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Align cart items to the top
                        Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cart.items.length,
                            itemBuilder: (ctx, i) {
                              final item = cart.items.values.toList()[i];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                                padding: EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF2A2A2A).withOpacity(0.1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image on the left
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              item.product.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Details in the middle
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.product.name,
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                                height: 1.22,
                                              ),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            item.product.description,
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.0,
                                                height: 1.22,
                                              ),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              // Quantity counter with outlined buttons
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xFF2A2A2A)),
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Implement decrease quantity functionality
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(Icons.remove,
                                                        size: 15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(item.quantity.toString()),
                                              SizedBox(width: 8),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xFF2A2A2A)),
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Implement increase quantity functionality
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(Icons.add,
                                                        size: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Delete button and price on the right
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cart.removeItem(
                                                cart.items.keys.toList()[i]);
                                          },
                                          child: Image.asset(
                                            'assets/images/trash.png', // Update this path to your delete icon image
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        Text(
                                          '\₦${item.product.price.toStringAsFixed(2)}',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                              height: 1.22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFEDEDED),
                            border:
                                Border.all(color: Color(0xFFFFC657), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Shopping Summary', // Your label text
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    height: 1.22,
                                    color: Color(0xFF2A2A2A),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Discount Code', // Your label text
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              height: 1.22,
                                              color: Color(0xFF2A2A2A)
                                                  .withOpacity(0.63),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                              borderSide: BorderSide(
                                                color: Color(0xFF2A2A2A)
                                                    .withOpacity(0.7),
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFF7F7D),
                                      foregroundColor: Color(0xFF2A2A2A),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Implement apply discount code functionality
                                    },
                                    child: Text(
                                      'Apply',
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
                              SizedBox(height: 40),
                              _buildShoppingSummaryRow('Subtotal', '2000'),
                              SizedBox(height: 10),
                              _buildShoppingSummaryRow('Delivery Fee',
                                  '\₦0.00'), // Replace with actual delivery fee calculation
                              SizedBox(height: 10),
                              _buildShoppingSummaryRow('Discount Amount',
                                  '-\₦0.00'), // Replace with actual discount amount calculation
                              SizedBox(height: 24),
                              Divider(
                                  height: 1,
                                  color: Color(0xFF2A2A2A).withOpacity(0.5)),
                              SizedBox(height: 24),
                              _buildShoppingSummaryRow('Total Amount', '3000'),
                              SizedBox(height: 24),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckoutScreen()),
                                  );
                                },
                                child: Text(
                                  'Checkout',
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
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          // Bottom Navigation Bar
          CustomBottomNavigationBar(
            selectedIndex: 1,
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
