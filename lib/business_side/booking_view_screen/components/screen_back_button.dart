import 'package:flutter/material.dart';

class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(25))),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            label: Text(
              'Booking',
              style: Theme.of(context).textTheme.headline5,
            )),
      ],
    );
  }
}
