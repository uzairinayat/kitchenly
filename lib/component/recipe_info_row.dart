import 'package:flutter/material.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';

class RecipeInfoRow extends StatelessWidget {
  final Map<String, dynamic> recipe;
  const RecipeInfoRow({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
        final responsive = Responsive(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(Icons.schedule, color: Colors.grey[700]),
            Text(
              "Cooking Time:",
              style: TextStyle(fontSize: responsive.fontSize(14, 20)),
            ),
            Text(
              "${recipe['cookTimeMinutes']} mins",
              style: TextStyle(
                color: ThemeColors.main,
                fontSize: responsive.fontSize(14, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant_menu, color: Colors.grey[700]),
            Text(
              "Serving:",
              style: TextStyle(fontSize: responsive.fontSize(14, 20)),
            ),
            Text(
              "${recipe['servings']} people",
              style: TextStyle(
                color: ThemeColors.main,
                fontSize: responsive.fontSize(14, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(Icons.signal_cellular_alt, color: Colors.grey[700]),
            Text(
              "Difficulty:",
              style: TextStyle(fontSize: responsive.fontSize(14, 20)),
            ),
            Text(
              "${recipe['difficulty']}",
              style: TextStyle(
                color: ThemeColors.main,
                fontSize: responsive.fontSize(14, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
