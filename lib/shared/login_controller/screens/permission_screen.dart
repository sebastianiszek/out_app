import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:out_app/shared/home_screen/components/splash_screen.dart';
import 'package:out_app/shared/login_controller/login_bridge.dart';

class PermissionBridge extends StatelessWidget {
  const PermissionBridge({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PermissionScreenText(text: '', showButton: false);
        }
        if (snapshot.hasError) {
          return const PermissionScreenText(
              text: 'Enable location to use the application', showButton: true);
        }
        if (snapshot.hasData) {
          return LoadApplicationSide(uid: uid);
        }
        return const PermissionScreenText(
            text: 'Loading...', showButton: false);
      },
    );
  }
}

class PermissionScreenText extends StatelessWidget {
  const PermissionScreenText(
      {Key? key, required this.text, required this.showButton})
      : super(key: key);
  final String text;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C2678),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', scale: 1),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            showButton
                ? TextButton(
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                      await Geolocator.openLocationSettings();
                    },
                    child: const Text('Open settings'))
                : Container()
          ],
        )));
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
