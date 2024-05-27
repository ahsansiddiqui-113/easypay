import 'package:easypay/BeneficiaryManagementScreen.dart';
import 'package:easypay/Login.dart';
import 'package:easypay/registrationScreen.dart';
import 'package:easypay/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: {
      '/login':(context)=> LoginScreen(),
      '/registration': (context) => RegistrationScreen(),
      '/beneficiary': (context) => BeneficiaryManagementScreen(),
    },
  ));
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
