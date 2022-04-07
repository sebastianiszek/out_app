import 'package:flutter/material.dart';

void outSnackbar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    text,
    textAlign: TextAlign.center,
    style: Theme.of(context)
        .textTheme
        .bodyText1
        ?.merge(const TextStyle(color: Colors.white)),
  )));
}
