import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RestaurantAvatar extends StatelessWidget {
  const RestaurantAvatar({Key? key, this.width, this.height}) : super(key: key);
  final dynamic width;
  final dynamic height;

  @override
  Widget build(BuildContext context) {
    // Points to the root reference
    final imageRef = FirebaseStorage.instance.ref().child('LED.png');

    return SizedBox(
        height: height.toDouble(),
        width: width.toDouble(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/images/placeholder.png',
              ),
            )));
  }
}
