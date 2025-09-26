import 'package:flutter/material.dart';
import 'package:kitchenly/component/auth_check.dart';
import 'package:kitchenly/component/cart_list.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/helper_widget.dart';
import 'package:provider/provider.dart';
import 'package:kitchenly/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.cartItems;
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: ThemeColors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (cartItems.isEmpty) {
              showSnackBar(context, content: 'Your cart is empty');
              return;
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthCheck()),
              );
            }
          },
          child: Row(
            children: [
              Text(
                "CheckOut :",
                style: TextStyle(
                  fontSize: responsive.fontSize(16, 22),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "Total: PKR ${cartProvider.totalPrice}", // ✅ Dynamic total
                style: TextStyle(
                  fontSize: responsive.fontSize(16, 22),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: CartList(),
    );
  }
}
