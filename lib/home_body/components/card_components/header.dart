import 'package:flutter/material.dart';

class RestaurantCardHeader extends StatelessWidget {
  const RestaurantCardHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Roboto", fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
