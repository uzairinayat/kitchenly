import 'package:flutter/material.dart';
import 'package:kitchenly/component/textfield.dart';
import 'package:kitchenly/screens/authentication/forgotpassword_screen.dart';
import 'package:kitchenly/screens/authentication/signup_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/buttons/login_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        elevation: 5,
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: responsive.fontSize(24, 30),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text field for email
                      CustomTextfield(
                        controller: emailController,
                        label: 'Email',
                        obscure: false,
                      ),

                      const SizedBox(height: 20),

                      // Text field for Password
                      CustomTextfield(
                        controller: passwordController,
                        label: 'Password',
                        obscure: true,
                      ),

                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ForgotpasswordScreen(), // Navigate to Forgot Password Page
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: ThemeColors.greyText,
                              fontSize: responsive.fontSize(
                                14,
                                18,
                              ), // font size for mobile is 14, for tablet is 18
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Login Button
                      LoginButton(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),

                      const SizedBox(height: 15),

                      // Secondary Text Button
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            color: ThemeColors.main,
                            fontSize: responsive.fontSize(14, 18),
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
