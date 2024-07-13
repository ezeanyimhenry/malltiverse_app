import 'package:flutter/material.dart';

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
