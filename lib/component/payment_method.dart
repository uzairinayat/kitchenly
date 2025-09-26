import 'package:flutter/material.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/widgets/helper_widget.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paymentMethods = [
      {"name": "EasyPaisa", "logo": "assets/easypaisa.png"},
      {"name": "JazzCash", "logo": "assets/jazzcash.png"},
      {"name": "Bank", "logo": "assets/bank.png"},
    ];

    final ValueNotifier<String> selectedMethod = ValueNotifier("EasyPaisa");
    final TextEditingController paymentDetailController =
        TextEditingController();
    final ValueNotifier<String> paymentDetails = ValueNotifier("");

    return ValueListenableBuilder<String>(
      valueListenable: selectedMethod,
      builder: (context, value, _) {
        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text("Select Payment Method"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: selectedMethod,
                            builder: (context, current, _) {
                              return Column(
                                children: paymentMethods.map((method) {
                                  return RadioListTile<String>(
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          method["logo"],
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(method["name"]),
                                      ],
                                    ),
                                    value: method["name"],
                                    groupValue: current,
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
                          const SizedBox(height: 10),
                          ValueListenableBuilder<String>(
                            valueListenable: selectedMethod,
                            builder: (context, current, _) {
                              return TextField(
                                controller: paymentDetailController,
                                decoration: InputDecoration(
                                  labelText: "Enter $current Account Number",
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
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: ThemeColors.greyText),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showSnackBar(
                              context,
                              content: "✅ Selected ${selectedMethod.value}",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.primary,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(color: ThemeColors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.payment),
              label: Text(
                "Payment: $value",
                style: TextStyle(color: ThemeColors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.main,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
