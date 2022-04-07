import 'dart:async';

import 'package:flutter/material.dart';
import 'package:out_app/shared/home_screen/components/splash_screen.dart';

import '../login_controller/login_controller.dart';

class OutHomeScreen extends StatefulWidget {
  const OutHomeScreen({Key? key}) : super(key: key);

  @override
  _OutHomeScreenState createState() => _OutHomeScreenState();
}

class _OutHomeScreenState extends State<OutHomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        //const Duration(seconds: 3),
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginController())));
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
