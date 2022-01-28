import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/top_section.dart';

import 'components/card.dart';
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
        RestaurantCard(
          title: 'Restaurant',
        ),
      ],
    );
  }
}
