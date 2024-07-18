// order_history_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/order_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final List<Order> orders = orderProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Content area
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight,
            child: Consumer<OrderProvider>(
              builder: (context, provider, child) {
                if (orders.isEmpty) {
                  return Center(
                    child: Text(
                      "No orders yet.",
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
                        ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return ListTile(
                              title: Text('Order ID: ${order.id}'),
                              subtitle: Text('Placed on: ${order.createdAt}'),
                              trailing: Text(
                                  'Total: \$${calculateTotal(order.products)}'),
                              // Implement onTap to navigate to detailed order view if needed
                            );
                          },
                        ),
                        // Align cart items to the top
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
          CustomBottomNavigationBar(
            selectedIndex: 1,
            onItemTapped: (index) {
              if (index == 0) {
                // Navigate to CartScreen
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
          )
        ],
      ),
    );
  }

  double calculateTotal(List<Product> products) {
    return products.fold(0, (total, product) => total + product.price);
  }
}
