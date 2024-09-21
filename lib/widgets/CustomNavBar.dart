import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomNavBar({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 25,
      ),
      onPressed: onPressed,
    );
  }
}
