import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hng_shopping_app_task/providers/wishlist_provider.dart';
import 'package:hng_shopping_app_task/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
    // print("Env file loaded successfully");
  } catch (e) {
    // print("Error loading .env file: $e");
  }
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: 'Malltiverse',
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
                  SplashScreen(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
