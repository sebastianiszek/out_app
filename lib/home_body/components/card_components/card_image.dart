import 'dart:ui';

import 'package:flutter/material.dart';

class RestaurantCardImage extends StatelessWidget {
  const RestaurantCardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//     fitWidth → const BoxFit
// Make sure the full width of the source is shown, regardless of whether this means the source overflows the target box vertically.

// To actually clip the content, use clipBehavior: Clip.hardEdge alongside this in a FittedBox.
//fit: BoxFit.fitWidth)
    return SizedBox(
        height: 100,
        width: 225,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            clipBehavior: Clip.hardEdge,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
              child: Image.asset(
                'assets/images/placeholder.png',
              ),
            )));
  }
}
