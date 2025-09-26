import 'package:flutter/material.dart';
import 'package:kitchenly/providers/auth_provider.dart';
import 'package:kitchenly/screens/checkout_screen.dart';
import 'package:kitchenly/theme/theme_colors.dart';
import 'package:kitchenly/utils/responsive.dart';
import 'package:kitchenly/widgets/helper_widget.dart';
import 'package:kitchenly/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
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

                final result = await auth.login(
                  widget.emailController.text.trim(),
                  widget.passwordController.text.trim(),
                );

                setState(() {
                  _isLoading = false;
                });

                // Check if the input fields are empty
                if (widget.emailController.text.isEmpty &&
                    widget.passwordController.text.isEmpty) {
                  showSnackBar(
                    context,
                    content: 'Please enter your email and password',
                  );
                } else if (widget.emailController.text.isEmpty) {
                  // Check if email is empty
                  showSnackBar(
                    context,
                   content: 'Please enter your email.');
                } else if (widget.passwordController.text.isEmpty) {
                  // Check if password is empty
                  showSnackBar(
                    context, 
                    content: 'Please enter your password.');
                } else if (result != null) {
                  // If login fails
                  showSnackBar(
                    context,
                    content: 'Your email or password is incorrect.',
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckoutScreen(),
                    ), // If login is successful, navigate to the CheckOut page on successful login
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Your account has been logged in successfully!',
                      ),
                      duration: Duration(seconds: 2),
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
                // If not loading, show the text 'Login'
                'Login',
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 24),
                  color: ThemeColors.white,
                ),
              ),
      ),
    );
  }
}
