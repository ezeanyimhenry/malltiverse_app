import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../providers/order_provider.dart';
import '../services/api_service.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<Map<String, Product>> _productsFuture;
  late List<Order> orders;

  @override
  void initState() {
    super.initState();
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orders = orderProvider.orders;
    _productsFuture = _fetchProductsForOrders();
  }

  Future<Map<String, Product>> _fetchProductsForOrders() async {
    final Map<String, Product> productMap = {};
    for (var order in orders) {
      for (var item in order.orderItems) {
        if (!productMap.containsKey(item.productId)) {
          try {
            final product = await ApiService().fetchProductById(item.productId);
            productMap[item.productId] = product;
          } catch (error) {
            print('Error fetching product: $error');
          }
        }
      }
    }
    return productMap;
  }

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat.currency(locale: 'en_NG', symbol: '₦');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Order History',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight,
            child: FutureBuilder<Map<String, Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  if (orders.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders yet.",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
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
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orders.length,
                            itemBuilder: (context, orderIndex) {
                              final order = orders[orderIndex];
                              return Column(
                                children: order.orderItems.map((item) {
                                  final product = products[item.productId];
                                  if (product == null) {
                                    return SizedBox.shrink();
                                  }

                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Image on the left
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(1),
                                              image: DecorationImage(
                                                image: NetworkImage(product
                                                        .photoUrls.isNotEmpty
                                                    ? product.photoUrls.first
                                                    : ''),
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
                                                  product.name,
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  product.description,
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11.0,
                                                    ),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical:
                                                          4), // Add padding
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xFFFF7F7D), // Background color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12), // Rounded corners
                                                  ),
                                                  child: Text(
                                                    "Completed",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.0,
                                                        color: Colors
                                                            .white, // Text color
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Price on the right
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                item.quantity.toString(),
                                                style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                priceFormat.format(item.price),
                                                style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(child: Text('No product details available'));
                }
              },
            ),
          ),
          CustomBottomNavigationBar(
            selectedIndex: 0,
            onItemTapped: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              } else if (index == 2) {
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

  double calculateTotal(List<OrderItem> products) {
    return products.fold(0, (total, product) => total + product.price);
  }
}
