import 'package:flutter/material.dart';
import 'package:kitchenly/component/textfield.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/buttons/signup_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmpasswordController = TextEditingController();

    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        elevation: 5,
        title: Text(
          "Sign Up",
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
                      // Text field for name
                      CustomTextfield(
                        controller: nameController,
                        label: 'Name',
                        obscure: false,
                      ),
                      const SizedBox(height: 20),

                      // Text field for email
                      CustomTextfield(
                        controller: emailController,
                        label: 'Email',
                        obscure: false,
                      ),

                      const SizedBox(height: 20),

                      // Text field for password
                      CustomTextfield(
                        controller: emailController,
                        label: 'Password',
                        obscure: true,
                      ),
                      const SizedBox(height: 20),

                      // Text field for confirm password
                      CustomTextfield(
                        controller: emailController,
                        label: 'Confirm Password',
                        obscure: true,
                      ),

                      const SizedBox(height: 30),

                      //Signup Button
                      SignUpButton(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmpasswordController,
                      ),

                      const SizedBox(height: 15),

                      // Secondary Text Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Already have an account? Log In",
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
