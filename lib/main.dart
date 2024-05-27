import 'package:easypay/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EasyPayApp());
}

class EasyPayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
