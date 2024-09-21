import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final InputDecoration decoration;
  final IconData prefixIcon; // Renamed from `icons` to `icon` for clarity
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.decoration,
    required this.prefixIcon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: decoration.copyWith(
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon, // Use the provided `icon`
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF27F01), // Outline color when focused
            width: 5.0, // Outline width when focused
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black, // Outline color when enabled
            width: 4, // Outline width when enabled
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
