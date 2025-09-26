import 'package:flutter/material.dart';
import 'package:kitchenly/component/textfield.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/buttons/forget_button.dart';

class ForgotpasswordScreen extends StatelessWidget {
  const ForgotpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        elevation: 5,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: ThemeColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🟢 Logo
                Image.asset(
                  "assets/logo.png",
                  height: responsive.isTablet
                      ? 250
                      : 200, // height for tablet is 250, for mobile is 200
                ),

                // 🟢 Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Enter your email to reset password",
                        style: TextStyle(
                          fontSize: 20,
                          color: ThemeColors.greyText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Text field for email
                      CustomTextfield(
                        controller: emailController,
                        label: 'Email',
                        obscure: false,
                      ),

                      const SizedBox(height: 30),

                      // Forgot Button
                      ForgetPasswordButton(emailController: emailController),
                      const SizedBox(height: 15),

                      // Secondary Text Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RichText(
                          text: TextSpan(
                            text: "Remembered your password? ",
                            style: TextStyle(
                              color: ThemeColors.greyText,
                              fontSize: responsive.fontSize(
                                14,
                                16,
                              ), // font size for mobile is 14, for tablet is 16
                            ),
                            children: const [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: ThemeColors.main,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
