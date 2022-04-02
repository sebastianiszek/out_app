import 'package:flutter/material.dart';
import 'package:out_app/out_app_icons.dart';
import 'package:out_app/restaurant_screen/components/stamps_section.dart';
import 'package:out_app/shared_components/button.dart';
import 'package:out_app/shared_components/table_icon.dart';

class RestaurantViewSecondSection extends StatelessWidget {
  const RestaurantViewSecondSection(
      {Key? key, required this.tables, required this.restaurantID})
      : super(key: key);

  final int tables;
  final String restaurantID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutStampsSection(
          restaurantID: restaurantID,
          padding: const EdgeInsets.fromLTRB(34, 6, 34, 8),
          stampsAlignment: MainAxisAlignment.spaceBetween,
          textAlignment: MainAxisAlignment.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: ElevatedButton.icon(
            style: getOutButtonStyle(const Color(0xFFEFE827)).merge(ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.black)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(40, 20, 40, 20)))),
            onPressed: () {},
            icon: const Icon(
              OutApp.logo,
              color: Colors.black,
            ),
            label: Text(
              "Book a Table",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTableIcon(tables, 24),
            Text(
              " " + tables.toString() + " Tables Available",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }
}
