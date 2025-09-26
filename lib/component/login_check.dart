import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitchenly/widgets/loader_widget.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Listen to authentication state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the authentication state
          return const Center(child: Loader()); // Show a loading indicator
        }

        if (snapshot.hasData) {
          // ✅ User is signed in
          return const Text(
            "Logged in",
            style: TextStyle(color: Colors.green, fontSize: 18),
          );
        } else {
          // ✅ User is not signed in
          return const Text(
            "Not logged in",
            style: TextStyle(color: Colors.red, fontSize: 18),
          );
        }
      },
    );
  }
}
