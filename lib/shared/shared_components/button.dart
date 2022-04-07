import 'package:flutter/material.dart';

ButtonStyle getOutButtonStyle(Color color) {
  return ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50), // <-- Radius
      )),
      backgroundColor: MaterialStateProperty.all(color));
}
