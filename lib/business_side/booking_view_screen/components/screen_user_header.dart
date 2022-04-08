import 'package:flutter/material.dart';

class ScreenUserHeader extends StatelessWidget {
  const ScreenUserHeader({Key? key, required this.userEmail}) : super(key: key);
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Icon(
              Icons.account_circle,
              size: 64,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              userEmail,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
