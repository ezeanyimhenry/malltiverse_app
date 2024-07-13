import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/star_rating.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
// import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define the screens corresponding to each bottom nav item
  static List<Widget> _screens(
          BuildContext context, PageController controller) =>
      <Widget>[
        MainScreenBody(controller: controller),
        CartScreen(),
        Placeholder(), // Replace with actual screen for profile
      ];

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to CartScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

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
        title: Text(
          'Product List',
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
          _screens(context, PageController())[
              _selectedIndex], // Display the selected screen
          CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
// Display the selected screen
    );
  }
}

class MainScreenBody extends StatelessWidget {
  final PageController controller; // Add this line

  MainScreenBody({required this.controller}); // Add this line

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        } else {
          List<Product> products =
              provider.products; // Retrieve products from provider

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Section
                  Container(
                    child: Stack(
                      children: [
                        // Banner image
                        Container(
                          width: double.infinity,
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/banner.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Overlay
                        Container(
                          width: double.infinity,
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.black.withOpacity(0.0),
                          ),
                        ),
                        // Text on top of the overlay
                        Positioned(
                          left: 26.0,
                          top: 73.0,
                          child: Container(
                            width: 250.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Premium Sound, Premium Savings',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                      color: Color(0xFFFAFAFA),
                                      textBaseline: TextBaseline.alphabetic,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Limited offer, hop on to get yours',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.22,
                                      color: Color(0xFFFAFAFA),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36.0,
                  ),

                  // Tech Gadgets Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Tech Gadgets',
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: PageView.builder(
                      controller: controller, // Use the provided controller
                      itemCount: (products.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            for (int i = index * 2;
                                i < (index * 2) + 2 && i < products.length;
                                i++)
                              Expanded(
                                child: InkWell(
                                  onTap: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                                product: products[i]),
                                      ),
                                    ),
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  products[i].imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height:
                                              180.0, // Adjust image height as needed
                                        ),
                                        SizedBox(height: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                products[i].name,
                                                style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    height: 1.22,
                                                    color: Color(0xFF2A2A2A),
                                                  ),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4.0),
                                              Text(
                                                products[i].description,
                                                style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.0,
                                                    height: 1.22,
                                                    color: Color(0xFF2A2A2A),
                                                  ),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4.0),
                                              StarRating(
                                                rating: 5,
                                                starSize: 20.0,
                                                starColor: Color(0xFFFFC657),
                                              ),
                                              SizedBox(height: 13.0),
                                              Text(
                                                '\₦${products[i].price.toStringAsFixed(2)}',
                                                style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.0,
                                                    height: 1.22,
                                                    color: Color(0xFFFF7F7D),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 17.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .addItem(products[i]);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Added to cart!'),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side: BorderSide(
                                                      width: 1.0,
                                                      color: Color(
                                                          0xFFFF7F7D)), // Border
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.0), // Border radius
                                                  ),
                                                ),
                                                child: Text(
                                                  'Add to Cart',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.0,
                                                      height: 1.22,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10.0),
                  Center(
                    child: DotsIndicator(
                      controller: controller, // Use the provided controller
                      itemCount: (products.length / 2).ceil(),
                      onPageSelected: (int page) {
                        controller.animateToPage(
                          page,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

// Dots Indicator Widget for PageView
class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;

  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: InkWell(
            onTap: () => onPageSelected(index),
            child: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (index == controller.page)
                    ? Color(0xFFFF7F7D)
                    : Color(0xFFBBBBBB),
              ),
            ),
          ),
        );
      }),
    );
  }
}
