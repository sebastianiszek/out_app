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

InputDecoration getOutLoginInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 18, 25, 18),
    filled: true,
    fillColor: const Color(0xFFFFFBFF),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color.fromARGB(176, 27, 27, 31),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
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
