import 'package:flutter/material.dart';

TextSpan getOpenedTextFormatted(bool opened) {
  if (opened) {
    return const TextSpan(
      text: 'Opened Now',
    );
  }
  return const TextSpan(
      // , style: TextStyle(color: Color(0xFFBA1B1B))
      text: 'Closed');
}

TextStyle getOpenedBulletStyle(bool opened) {
  TextStyle openedStyle = const TextStyle(
    color: Color.fromARGB(255, 36, 186, 41),
    // fontWeight: FontWeight.bold,
  );
  if (!opened) {
    openedStyle = const TextStyle(
      color: Color(0xFFBA1B1B),
      fontWeight: FontWeight.bold,
    );
  }
  return openedStyle;
}
