import 'package:flutter/material.dart';
import 'package:kitchenly/providers/auth_provider.dart';
import 'package:kitchenly/screens/authentication/login_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/helper_widget.dart';
import 'package:kitchenly/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const SignUpButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context); // Access the AuthProvider
    final responsive = Responsive(context); // Responsive Screens
    return SizedBox(
      width: double.infinity, // Full width button
      child: ElevatedButton(
        onPressed:
            _isLoading // If loading, disable the button
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                final result = await auth.signUp(
                  widget.emailController.text.trim(),
                  widget.passwordController.text.trim(),
                );
                setState(() {
                  _isLoading = false;
                });

                // Check if any of the input fields is empty
                if (widget.nameController.text.isEmpty &&
                    widget.emailController.text.isEmpty &&
                    widget.passwordController.text.isEmpty &&
                    widget.confirmPasswordController.text.isEmpty) {
                  showSnackBar(context, content: 'Please enter your details.');
                } else if (widget.emailController.text.isEmpty) {
                  // Check if email is empty
                  showSnackBar(context, content: 'Please enter your email.');
                } else if (widget.passwordController.text.isEmpty) {
                  // Check if password is empty

                  showSnackBar(context, content: 'Please enter your password.');
                } else if (widget
                        .passwordController
                        .text != // Check if password and confirm password match
                    widget.confirmPasswordController.text) {
                  showSnackBar(context, content: 'Passwords do not match');
                } else if (result != null && result != true) {
                  // If there is an error from the signUp method

                  showSnackBar(context, content: '$result');
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LogInScreen(),
                    ), // If sign up is successful, navigate to Login Screen
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: ThemeColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:
            _isLoading // If loading, show a CircularProgressIndicator
            ? const SizedBox(height: 24, width: 24, child: Loader())
            : Text(
                // If not loading, show the text 'Sign Up'
                'Sign Up',
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 24),
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
