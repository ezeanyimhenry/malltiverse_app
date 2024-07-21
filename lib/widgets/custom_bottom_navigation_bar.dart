import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/main_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: (selectedIndex == 0)
                          ? const Color(0xFFFF7F7D)
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/home-icon.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              label: '', // Set label to an empty string
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: (selectedIndex == 1)
                          ? const Color(0xFFFF7F7D)
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/shopping-cart-icon.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              label: '', // Set label to an empty string
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: (selectedIndex == 2)
                          ? const Color(0xFFFF7F7D)
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/checkout-icon.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              label: '', // Set label to an empty string
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white, // Color for selected icon
          unselectedItemColor: Colors.white, // Color for unselected icons
          onTap: (index) {
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
                MaterialPageRoute(builder: (context) => const CheckoutScreen()),
              );
            }
          },
          backgroundColor: const Color(0xFF2A2A2A),
          elevation: 8.0, // Add elevation to make it float
          type: BottomNavigationBarType.fixed,
          iconSize: 24,
          selectedFontSize: 0,
          selectedIconTheme: const IconThemeData(
            size: 24,
            color: Colors.white,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
