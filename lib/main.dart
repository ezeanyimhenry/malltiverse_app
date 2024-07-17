import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'screens/main_screen.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
    // print("Env file loaded successfully");
  } catch (e) {
    // print("Error loading .env file: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final int _selectedIndex = 0;

  // static final List<Widget> _screens = [
  //   MainScreen(),
  //   CartScreen(),
  //   CheckoutScreen(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

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
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  MainScreen(),
                  // _screens[_selectedIndex],
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
