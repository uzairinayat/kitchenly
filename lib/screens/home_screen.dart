import 'package:flutter/material.dart';
import 'package:kitchenly/component/login_check.dart';
import 'package:kitchenly/component/recipe_list.dart';
import 'package:kitchenly/component/search_bar.dart';
import 'package:kitchenly/component/sort_dropdown.dart';
import 'package:kitchenly/providers/auth_provider.dart';
import 'package:kitchenly/providers/cart_provider.dart';
import 'package:kitchenly/providers/recipe_provider.dart';
import 'package:kitchenly/screens/cart_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context); // Access the AuthProvider
    final responsive = Responsive(context);

    // Load recipes when page builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().loadRecipes();
    });

    return Scaffold(
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.main,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(55),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: responsive.iconSize(28, 36),
                  color: ThemeColors.white,
                ),
              ),

              // 🔹 Cart count badge
              if (cartProvider.cartCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartProvider.cartCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.fontSize(12, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      backgroundColor: ThemeColors.white,
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          children: [
            /// Greeting
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Hello, User",
                      style: TextStyle(
                        fontSize: responsive.fontSize(18, 24),
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.main,
                      ),
                    ),
                    LoginCheck(),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    auth.logout();
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    fontWeight: FontWeight.bold,
                    size: responsive.iconSize(28, 36),
                    color: ThemeColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// Search field
            CustomSearchBar(),

            /// Section title
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Recipes",
                      style: TextStyle(
                        fontSize: responsive.fontSize(20, 26),
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.primary,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const RecipeSortDropdown(),
              ],
            ),

            /// Recipes List
            RecipeList(),
          ],
        ),
      ),
    );
  }
}
