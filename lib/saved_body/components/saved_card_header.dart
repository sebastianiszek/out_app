import 'package:flutter/material.dart';

class SavedCardHeader extends StatelessWidget {
  const SavedCardHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              height: 1,
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
