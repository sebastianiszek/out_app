import 'package:flutter/material.dart';

class SearchCardHeader extends StatelessWidget {
  const SearchCardHeader({Key? key, required this.title}) : super(key: key);
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
              height: 0.8,
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
