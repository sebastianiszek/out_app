import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:out_app/home_screen/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //outBlue colour
  final MaterialColor outBlue = const MaterialColor(0xFF4D57A9, {
    50: Color(0xFFF0EFFF),
    100: Color(0xFFDEE0FF),
    200: Color(0xFFBBC2FF),
    300: Color(0xFF9BA5FD),
    400: Color(0xFF808AE0),
    500: Color(0xFF6670C4),
    600: Color(0xFF4D57A9),
    700: Color(0xFF343E8F),
    800: Color(0xFF1C2678),
    900: Color(0xFF000965)
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF4D57A9),
        primarySwatch: outBlue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: outBlue,
          primaryColorDark: const Color(0xFF1C2678),
          accentColor: const Color(0xFFEFE827),
          backgroundColor: const Color(0xFFFFFBFF),
          errorColor: const Color(0xFFBA1B1B),
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        fontFamily: 'Varela Round',
      ),
      home: const OutHomeScreen(),
    );
  }
}
