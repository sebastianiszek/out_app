import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C2678),
        body: Center(
          child: Image.asset('assets/images/logo.png', scale: 1),
        ));
  }
}
