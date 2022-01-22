import 'dart:async';

import 'package:flutter/material.dart';
import 'package:out_app/home_screen/components/splash_screen.dart';

import 'components/home.dart';

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
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
