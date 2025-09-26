import 'package:flutter/material.dart';
import 'package:kitchenly/component/recipe_info_row.dart';
import 'package:kitchenly/utils/responsive.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.fontSize(22, 28),
                ),
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.network(recipe['image'], fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name & Points
                  Text(
                    recipe['name'],
                    style: TextStyle(
                      fontSize: responsive.fontSize(22, 28),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "⭐ ${recipe['rating']} Rating",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: responsive.fontSize(16, 22),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${recipe['reviewCount']} Reviewed",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: responsive.fontSize(16, 22),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row Information
                  RecipeInfoRow(recipe: recipe),

                  const SizedBox(height: 20),

                  /// Ingredients section
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: responsive.fontSize(18, 24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Ingredients list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      (recipe['ingredients'] as List).length,
                      (index) => Text(
                        "- ${recipe['ingredients'][index]}",
                        style: TextStyle(fontSize: responsive.fontSize(16, 22)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Instructions section
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Instructions",
                          style: TextStyle(
                            fontSize: responsive.fontSize(18, 24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      (recipe['instructions'] as List).length,
                      (index) => Text(
                        "${index + 1}. ${recipe['instructions'][index]}",
                        style: TextStyle(fontSize: responsive.fontSize(16, 22)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
