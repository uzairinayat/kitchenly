import 'package:flutter/material.dart';
import 'package:kitchenly/providers/cart_provider.dart';
import 'package:kitchenly/screens/home_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/helper_widget.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final List<String> paymentMethods = [
      "EasyPaisa",
      "JazzCash",
      "Bank",
    ];

    final ValueNotifier<String> selectedMethod = ValueNotifier("EasyPaisa");
    final TextEditingController paymentDetailController =
        TextEditingController();
    final ValueNotifier<String> paymentDetails = ValueNotifier("");
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
            fontSize: responsive.fontSize(24, 30),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: ThemeColors.white,
      body: Column(
        children: [
          // 🛒 Cart Items
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      cartItem['image'] ?? "",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cartItem['name'] ?? "Recipe"),
                    subtitle: Text("PKR ${cartItem['price']}"),
                    trailing: Text("x${cartItem['quantity']}"),
                  ),
                );
              },
            ),
          ),

          // 💵 Payment Selection
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text(
                  "Select Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ValueListenableBuilder<String>(
                  valueListenable: selectedMethod,
                  builder: (context, value, _) {
                    return Column(
                      children: paymentMethods.map((method) {
                        return RadioListTile<String>(
                          title: Text(method),
                          value: method,
                          groupValue: value,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              selectedMethod.value = newValue;
                              paymentDetailController.clear();
                              paymentDetails.value = "";
                            }
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
                ValueListenableBuilder<String>(
                  valueListenable: selectedMethod,
                  builder: (context, value, _) {
                    return TextField(
                      controller: paymentDetailController,
                      decoration: InputDecoration(
                        labelText: "Enter $value Account Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) => paymentDetails.value = val,
                    );
                  },
                ),
              ],
            ),
          ),

          // 📊 Total & Confirm
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Total: PKR ${cartProvider.totalPrice}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (paymentDetails.value.isEmpty) {
                          showSnackBar(
                            context,
                            content: '⚠️ Please enter payment details',
                          );

                          return;
                        }
                        showSnackBar(
                          context,
                          content:
                              "✅ Order confirmed with ${selectedMethod.value}\n"
                              "Details: ${paymentDetails.value}\n"
                              "Total: PKR ${cartProvider.totalPrice}",
                        );

                        cartProvider.clearCart();
                        selectedMethod.value = "EasyPaisa";
                        paymentDetails.value = "";
                        paymentDetailController.clear();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Confirm Order",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
