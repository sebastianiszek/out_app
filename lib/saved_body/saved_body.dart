import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/divider.dart';
import 'package:out_app/saved_body/components/saved_card.dart';
import 'package:out_app/shared_components/input.dart';

class SavedBody extends StatelessWidget {
  const SavedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: TextFormField(
            decoration: getOutInputDecoration(
                const Color(0xFFDEE0FF), const Color(0xFF000965)),
          ),
        ),
        const DividerPadding(),
        const SavedCard(),
      ],
    );
  }
}
