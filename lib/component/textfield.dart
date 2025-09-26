import 'package:flutter/material.dart';
import 'package:kitchenly/theme/theme_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.obscure,
  });

  final TextEditingController controller;
  final String label;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: ThemeColors.main,
      obscureText:
          obscure, // If true, the text will be obscured (e.g., for passwords) and if false, the text will be visible
      style: const TextStyle(color: ThemeColors.main),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: ThemeColors.greyText),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.main, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
