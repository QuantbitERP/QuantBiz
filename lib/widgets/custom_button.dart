import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon; // Optional icon
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CustomButton({
    required this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          SizedBox(width: icon != null ? 8.0 : 0.0), // Add spacing if there's an icon
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}