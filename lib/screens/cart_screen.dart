import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

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
          'Cart',
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
                        textStyle: const TextStyle(
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cart.items.length,
                            itemBuilder: (ctx, i) {
                              final item = cart.items.values.toList()[i];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF2A2A2A)
                                          .withOpacity(0.1),
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
                                          image: NetworkImage(item
                                                  .product.photoUrls.isNotEmpty
                                              ? item.product.photoUrls.first
                                              : 'https://via.placeholder.com/60'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Details in the middle
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.product.name,
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                                height: 1.22,
                                              ),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.product.description,
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.0,
                                                height: 1.22,
                                              ),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              // Quantity counter with outlined buttons
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF2A2A2A)),
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Implement decrease quantity functionality
                                                    cart.decreaseQuantity(
                                                        item.product.id);
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: Icon(Icons.remove,
                                                        size: 15),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(item.quantity.toString()),
                                              const SizedBox(width: 8),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF2A2A2A)),
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Implement increase quantity functionality
                                                    // cart.addItem(item.product);
                                                    cart.increaseQuantity(
                                                        item.product.id);
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
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
                                        const SizedBox(height: 40),
                                        Text(
                                          '₦${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
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
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEDED),
                            border: Border.all(
                                color: const Color(0xFFFFC657), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Shopping Summary', // Your label text
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    height: 1.22,
                                    color: Color(0xFF2A2A2A),
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                              color: const Color(0xFF2A2A2A)
                                                  .withOpacity(0.63),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                              borderSide: BorderSide(
                                                color: const Color(0xFF2A2A2A)
                                                    .withOpacity(0.7),
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF7F7D),
                                      foregroundColor: const Color(0xFF2A2A2A),
                                      padding: const EdgeInsets.symmetric(
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
                                        textStyle: const TextStyle(
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
                              const SizedBox(height: 40),
                              _buildShoppingSummaryRow('Subtotal',
                                  '₦${cart.totalAmount.toStringAsFixed(2)}'),
                              const SizedBox(height: 10),
                              _buildShoppingSummaryRow('Delivery Fee',
                                  '₦0.00'), // Replace with actual delivery fee calculation
                              const SizedBox(height: 10),
                              _buildShoppingSummaryRow('Discount Amount',
                                  '-₦0.00'), // Replace with actual discount amount calculation
                              const SizedBox(height: 24),
                              Divider(
                                  height: 1,
                                  color:
                                      const Color(0xFF2A2A2A).withOpacity(0.5)),
                              const SizedBox(height: 24),
                              _buildShoppingSummaryRow('Total Amount',
                                  '₦${cart.totalAmount.toStringAsFixed(2)}'),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF7F7D),
                                  foregroundColor: const Color(0xFF2A2A2A),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckoutScreen()),
                                  );
                                },
                                child: Text(
                                  'Checkout',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          const CustomBottomNavigationBar(
            selectedIndex: 1,
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
              color: const Color(0xFF2A2A2A).withOpacity(0.8),
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
              color: const Color(0xFF2A2A2A).withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
