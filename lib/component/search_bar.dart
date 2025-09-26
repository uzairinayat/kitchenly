import 'package:flutter/material.dart';
import 'package:kitchenly/providers/recipe_provider.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final responsive = Responsive(context);

    return TextField(
      cursorColor: ThemeColors.main,
      controller: searchController,
      style: TextStyle(
        color: ThemeColors.main,
        fontSize: responsive.fontSize(18, 24),
      ),
      onChanged: (value) {
        context.read<RecipeProvider>().searchRecipes(value);
      },
      decoration: InputDecoration(
        hintText: "Search Recipes",
        hintStyle: TextStyle(
          color: ThemeColors.greyText,
          fontSize: responsive.fontSize(18, 24),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.main, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
