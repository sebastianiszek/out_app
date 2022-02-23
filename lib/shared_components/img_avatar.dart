import 'package:flutter/material.dart';

SizedBox restaurantAvatar(dynamic width, dynamic height) {
  return SizedBox(
      height: height,
      width: width,
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
