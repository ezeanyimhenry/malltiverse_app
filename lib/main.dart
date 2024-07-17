import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hng_shopping_app_task/widgets/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'screens/main_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
    // print("Env file loaded successfully");
  } catch (e) {
    // print("Error loading .env file: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _screens = [
    MainScreen(),
    CartScreen(),
    CheckoutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  _screens[_selectedIndex],
                  // CustomBottomNavigationBar(
                  //   selectedIndex: _selectedIndex,
                  //   onItemTapped: _onItemTapped,
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
