import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Dots Indicator Widget for PageView
class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;

  const DotsIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
  }) : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: SmoothPageIndicator(
          controller: controller,
          count: itemCount,
          effect: const ScaleEffect(
            dotHeight: 12.0,
            dotWidth: 12.0,
            activeDotColor: Color(0xFFFF7F7D),
            // Custom properties for outlined dots
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
