import 'package:flutter/material.dart';
import 'package:tien/Screen/Cart/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:tien/Screen/Cart/cart_provider.dart';
import 'package:tien/Screen/welcome/intro_page.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:IntroPage(),
    );
  }
}
