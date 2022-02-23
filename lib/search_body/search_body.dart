import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/card_components/header.dart';
import 'package:out_app/home_body/components/card_components/price.dart';
import 'package:out_app/home_body/components/card_components/subhead.dart';
import 'package:out_app/home_body/components/divider.dart';
import 'package:out_app/search_body/components/search_card.dart';
import 'package:out_app/shared_components/button.dart';
import 'package:out_app/shared_components/img_avatar.dart';
import 'package:out_app/shared_components/input.dart';
import 'package:out_app/shared_components/restaurant_tables_head.dart';

import 'components/search_card_header.dart';
import 'components/search_card_subhead.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

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
        const SearchCard(),
        const SearchCard(),
        const SearchCard(),
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                style:
                    getOutButtonStyle(Theme.of(context).colorScheme.secondary),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Notify me of offers',
                      style: Theme.of(context).textTheme.bodyText1),
                )))
      ],
    );
  }
}
