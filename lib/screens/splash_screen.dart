import 'package:flutter/material.dart';
import 'package:kitchenly/screens/home_screen.dart';
import 'package:kitchenly/widgets/loader_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    final logoHeight = isTablet ? 250.0 : 200.0;
    final verticalSpacing = isTablet ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              height: logoHeight,
            ), // Logo image
            SizedBox(height: verticalSpacing),
            Loader(),
          ],
        ),
      ),
    );
  }
}
