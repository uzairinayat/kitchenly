import 'package:flutter/material.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/reset_password.dart';
import 'package:kitchenly/utils/responsive.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final email = emailController.text.trim();
          if (email.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter your email."),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
          sendPasswordReset(context, email);
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: ThemeColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Reset Password",
          style: TextStyle(
            fontSize: responsive.fontSize(18, 24),
            color: ThemeColors.white,
          ),
        ),
      ),
    );
  }
}
