import 'package:flutter/material.dart';

InputDecoration getOutInputDecoration(Color background, Color onBackground) {
  return InputDecoration(
    contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 2, 25, 2),
    filled: true,
    fillColor: background,
    hintText: 'Search',
    hintStyle: TextStyle(
      color: onBackground,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    suffixIcon: Icon(
      Icons.search,
      color: onBackground,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  );
}
