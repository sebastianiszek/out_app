import 'package:flutter/material.dart';

class SavedCardHeader extends StatelessWidget {
  const SavedCardHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    String sTitle = title;

    if (title.length > 24) {
      sTitle = title.substring(0, 22) + '...';
    }

    return Row(
      children: [
        Text(
          sTitle,
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
