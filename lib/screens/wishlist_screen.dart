import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlist = wishlistProvider.wishlist;

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
          'Wishlist',
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
              child: wishlist.isEmpty
                  ? Center(
                      child: Text(
                        "No items in wishlist",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            height: 1.22, // Calculated as 14.63 / 12.0
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Align cart items to the top
                          Align(
                            alignment: Alignment.topCenter,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: wishlist.length,
                              itemBuilder: (ctx, i) {
                                final product = wishlist[i];
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
                                              product.name,
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
                                              product.description,
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
                                              wishlistProvider
                                                  .toggleWishlist(product);
                                            },
                                            child: Image.asset(
                                              'assets/images/trash.png', // Update this path to your delete icon image
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          Text(
                                            '₦${product.price.toStringAsFixed(2)}',
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      ),
                    )),
          const CustomBottomNavigationBar(
            selectedIndex: 0,
          )
        ],
      ),
    );
  }
}
