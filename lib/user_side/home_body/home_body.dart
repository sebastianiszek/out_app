import 'package:flutter/material.dart';
import 'package:out_app/user_side/home_body/components/card_section.dart';
import 'package:out_app/user_side/home_body/components/top_section.dart';

import 'components/divider.dart';
import 'components/header.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TopSection(),
        DividerPadding(),
        BuildHeader(
          text: "Close to you",
        ),
        HomeCardSection(),
      ],
    );
  }
}