import 'package:flutter/material.dart';
import 'package:kitchenly/providers/cart_provider.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/helper_widget.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
      final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.cartItems;
    final responsive = Responsive(context);
    return cartItems.isEmpty
        ? Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(
                fontSize: responsive.fontSize(18, 24),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final recipe = cartItems[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                          height: 210,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Recipe Name + Price
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    recipe['name'],
                                    style: TextStyle(
                                      fontSize: responsive.fontSize(16, 22),
                                      fontWeight: FontWeight.bold,
                                      color: ThemeColors.main,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "PKR ${(recipe['price'] * recipe['quantity'])}", // Price × Quantity
                                  style: TextStyle(
                                    fontSize: responsive.fontSize(16, 22),
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColors.primary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            /// Short Description (first instruction line)
                            if (recipe['instructions'] != null &&
                                recipe['instructions'].isNotEmpty)
                              Text(
                                recipe['instructions'][0],
                                style: TextStyle(
                                  fontSize: responsive.fontSize(12, 18),
                                  color: ThemeColors.greyText,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                            const SizedBox(height: 8),
                            Row(
                              children: [
                                /// Decrease Button
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                    size: responsive.iconSize(18, 24),
                                  ),
                                  onPressed: () {
                                    cartProvider.decreaseQuantity(recipe);

                                    showSnackBar(
                                      context,
                                      content:
                                          '1 ${recipe['name']} is deducted',
                                    );
                                  },
                                ),

                                /// Quantity
                                Text(
                                  "${recipe['quantity']}",
                                  style: TextStyle(
                                    fontSize: responsive.fontSize(16, 22),
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColors.main,
                                  ),
                                ),

                                /// Increase Button
                                IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                    size: responsive.iconSize(18, 24),
                                  ),
                                  onPressed: () {
                                    cartProvider.increaseQuantity(recipe);
                                    showSnackBar(
                                      context,
                                      content: '1 ${recipe['name']} is added',
                                    );
                                  },
                                ),
                                const Spacer(),

                                /// Delete Button
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: ThemeColors.greyText,
                                  ),
                                  onPressed: () {
                                    cartProvider.removeFromCart(recipe);
                                    showSnackBar(
                                      context,
                                      content: '${recipe['name']} is deleted',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
