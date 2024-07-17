import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double starSize;
  final Color starColor;

  const StarRating({
    super.key,
    required this.rating,
    this.starSize = 20.0,
    this.starColor = const Color(0xFFFFC657),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(
            Icons.star,
            size: starSize,
            color: starColor,
          );
        } else {
          return Icon(
            Icons.star_border,
            size: starSize,
            color: starColor,
          );
        }
      }),
    );
  }
}
