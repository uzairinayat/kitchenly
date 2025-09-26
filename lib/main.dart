import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kitchenly/firebase_options.dart';
import 'package:kitchenly/providers/auth_provider.dart';
import 'package:kitchenly/providers/cart_provider.dart';
import 'package:kitchenly/providers/checkout_provider.dart';
import 'package:kitchenly/providers/recipe_provider.dart';
import 'package:kitchenly/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await Firebase.initializeApp(
    // Initialize Firebase with default options
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchenly',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
