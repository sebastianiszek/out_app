import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/business_side/business_home_screen.dart/business_home_screen.dart';
import 'package:out_app/shared/home_screen/components/home.dart';
import 'package:out_app/shared/home_screen/components/splash_screen.dart';
import 'package:out_app/shared/login_controller/screens/login_screen.dart';

class LoadApplicationSide extends StatelessWidget {
  const LoadApplicationSide({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    DocumentReference user =
        FirebaseFirestore.instance.collection('Users').doc(uid);

    return FutureBuilder<DocumentSnapshot>(
      future: user.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return ListView(
            children: const [BackButton(), Text("Something went wrong...")],
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const HomeScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['restaurant'] != null) {
            return const BusHomeScreen();
          }
          return const HomeScreen();
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return const SplashScreen();
      },
    );
  }
}
