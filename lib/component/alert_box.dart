import 'package:flutter/material.dart';
import 'package:kitchenly/screens/authentication/login_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Responsive screens

    return AlertDialog(
      backgroundColor: ThemeColors.white,
      elevation: 5,
      shadowColor: ThemeColors.inactiveStep,
      title: Text(
        "Please Login First",
        style: TextStyle(
          fontSize: responsive.fontSize(18, 22),
          color: ThemeColors.main,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "You need to be logged in to proceed checkout.",
        style: TextStyle(
          fontSize: responsive.fontSize(16, 20),
          color: ThemeColors.greyText,
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(ThemeColors.inactiveStep),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            "back",
            style: TextStyle(
              fontSize: responsive.fontSize(16, 20),
              color: ThemeColors.greyText,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(ThemeColors.primary),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return const LogInScreen();
                },
              ),
            );
          },
          child: Text(
            "login now",
            style: TextStyle(
              fontSize: responsive.fontSize(16, 20),
              color: ThemeColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
