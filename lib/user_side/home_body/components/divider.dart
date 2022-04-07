import 'package:flutter/material.dart';

class DividerPadding extends StatelessWidget {
  const DividerPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Divider(),
    );
  }
}
