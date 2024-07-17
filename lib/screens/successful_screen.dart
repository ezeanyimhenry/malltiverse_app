import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';
import 'package:confetti/confetti.dart';

class SuccessfulScreen extends StatefulWidget {
  const SuccessfulScreen({super.key});

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController
        .play(); // Play the confetti animation when the screen is initialized
  }

  @override
  void dispose() {
    _confettiController
        .dispose(); // Dispose the controller to free up resources
    super.dispose();
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
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Payment Successful',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          height: 1.22,
                          color: Color(0xFF2A2A2A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  Column(children: [
                    Image.asset('assets/images/check.png'),
                    const SizedBox(
                      height: 14,
                    ),
                    Center(
                      child: Text(
                        'Payment Successful',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            height: 1.22,
                            color: Color(0xFF2A2A2A),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Center(
                      child: Text(
                        'Thanks for your purchase',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false, // Set to true for continuous celebration
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.purple,
                Colors.orange
              ], // Colors of confetti
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
