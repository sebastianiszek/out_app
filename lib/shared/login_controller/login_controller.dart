import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/login_controller/screens/login_screen.dart';
import 'package:out_app/shared/login_controller/screens/permission_screen.dart';

class LoginController extends StatefulWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PermissionBridge(uid: snapshot.data!.uid);
          }
          return const LoginScreen();
        });
  }
}
