import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Base Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double radius;
  final double borderWidth;
  final ButtonStyle style;

  CustomButton({
    required this.text,
    required this.onPressed,
    required this.style,
    this.width = 93,
    this.height = 38,
    this.radius = 14,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
              height: 1.22, // Calculated as 14.63 / 12.0
            ),
          ),
        ),
      ),
    );
  }
}

// Primary Button Style
class PrimaryButtonStyle {
  static final ButtonStyle style = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.0), // Border radius
    ),
  );
}

// Outlined Button Style
class OutlinedButtonStyle {
  static final ButtonStyle style = OutlinedButton.styleFrom(
    side: BorderSide(width: 1.0, color: Color(0xFFFF7F7D)), // Border
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.0), // Border radius
    ),
  );
}
