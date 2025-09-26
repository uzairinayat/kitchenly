import 'package:flutter/material.dart';
import 'package:kitchenly/providers/cart_provider.dart';
import 'package:kitchenly/providers/recipe_provider.dart';
import 'package:kitchenly/screens/recipedetail_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/recipe_prices.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/helper_widget.dart';
import 'package:kitchenly/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Expanded(
      child: Consumer<RecipeProvider>(
        builder: (context, recipeProvider, child) {
          if (recipeProvider.isLoading) {
            return const Center(child: Loader());
          } else if (recipeProvider.error != null) {
            return Center(child: Text("Error: ${recipeProvider.error}"));
          } else if (recipeProvider.recipes.isEmpty) {
            return const Center(child: Text("No recipes found"));
          }

          final recipes = recipeProvider.recipes;

          return ListView.builder(
            itemCount: recipes.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final recipe = recipes[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.inactiveStep,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Recipe Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        recipe['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Recipe Name
                          Text(
                            recipe['name'],
                            style: TextStyle(
                              fontSize: responsive.fontSize(16, 22),
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.main,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 5),

                          /// Short Description
                          Text(
                            recipe['instructions'][0],
                            style: TextStyle(
                              fontSize: responsive.fontSize(14, 20),
                              color: ThemeColors.main,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "PKR ${recipePrices[index % recipePrices.length]}",
                            style: TextStyle(
                              fontSize: responsive.fontSize(13, 17),
                              color: ThemeColors.primary,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              /// Detail Button
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ThemeColors.inactiveStep,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecipeDetailsScreen(recipe: recipe),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: responsive.fontSize(14, 20),
                                      color: ThemeColors.white,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              /// Add to Cart Button
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ThemeColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<CartProvider>().addToCart(
                                      recipe,
                                      recipePrices[index % recipePrices.length],
                                    );

                                    showSnackBar(
                                      context,
                                      content:
                                          "${recipe['name']} added to cart!",
                                    );
                                  },
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      fontSize: responsive.fontSize(14, 20),
                                      color: ThemeColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
