import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showOutDialog(BuildContext context, String text) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
          content: Text(
            text,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))));
    },
  );
}
