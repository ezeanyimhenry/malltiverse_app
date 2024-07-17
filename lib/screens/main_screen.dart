import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import '../widgets/dot_indicator.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/star_rating.dart';
import 'checkout_screen.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .fetchCategories();
        await Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts();
      } catch (error) {
        // print('Error fetching data: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    });
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
          'Product List', // Update the title based on selected index
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
          SingleChildScrollView(
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                if (_isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (productProvider.errorMessage != null) {
                  return Center(
                      child: Text('Error: ${productProvider.errorMessage}'));
                } else {
                  // final categoriesWithProducts = productProvider.categories
                  //     .where((category) => productProvider.products.any(
                  //         (product) => product.categories.contains(category.id)))
                  //     .toList();

                  final categoriesWithProducts = productProvider.categories;

                  // print('Categories with products: $categoriesWithProducts');
                  if (categoriesWithProducts.isEmpty) {
                    return const Center(
                        child: Text('No categories with products.'));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            // Banner image
                            Container(
                              width: double.infinity,
                              height: 250.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/banner.jpeg'),
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
                              child: SizedBox(
                                width: 250.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Premium Sound, Premium Savings',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          height: 1.4,
                                          color: Color(0xFFFAFAFA),
                                          textBaseline: TextBaseline.alphabetic,
                                        ),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Limited offer, hop on to get yours',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
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
                        const SizedBox(
                          height: 36.0,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoriesWithProducts.length,
                          itemBuilder: (context, index) {
                            final category = categoriesWithProducts[index];
                            return CategorySlider(category: category);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          CustomBottomNavigationBar(
            selectedIndex: 0,
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

class CategorySlider extends StatefulWidget {
  final Category category;

  const CategorySlider({super.key, required this.category});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  final PageController _pageController = PageController();
  bool _productsFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.fetchProductsByCategory(widget.category.id);
    setState(() {
      _productsFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    // final productsInCategory = productProvider.products
    //     .where((product) => product.categories.contains(widget.category.id))
    //     .toList();
    final productsInCategory = productProvider.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.category.name,
            style: GoogleFonts.montserrat(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (!_productsFetched)
          const Center(child: CircularProgressIndicator())
        else if (productsInCategory.isEmpty)
          const Center(child: Text('No Products in this Category'))
        else
          SizedBox(
            height: 400,
            child: PageView.builder(
              controller: _pageController,
              itemCount: (productsInCategory.length / 2).ceil(),
              itemBuilder: (context, index) {
                // final product = productsInCategory[index];
                return Row(
                  children: [
                    for (int i = index * 2;
                        i < (index * 2) + 2 && i < productsInCategory.length;
                        i++)
                      ProductCard(product: productsInCategory[i]),
                  ],
                );
              },
            ),
          ),
        DotsIndicator(
            controller: _pageController,
            itemCount: (productsInCategory.length / 2).ceil()),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          ),
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 180.0,
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        height: 1.22,
                        color: const Color(0xFF2A2A2A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      product.description,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        height: 1.22,
                        color: const Color(0xFF2A2A2A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    StarRating(
                      rating: product.rating,
                      starSize: 20.0,
                      starColor: const Color(0xFFFFC657),
                    ),
                    const SizedBox(height: 13.0),
                    Text(
                      '₦${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        height: 1.22,
                        color: const Color(0xFFFF7F7D),
                      ),
                    ),
                    const SizedBox(height: 17.0),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            width: 1.0, color: Color(0xFFFF7F7D)), // Border
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14.0), // Border radius
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
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
    );
  }
}
