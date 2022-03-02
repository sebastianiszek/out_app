import 'package:flutter/material.dart';
import 'package:out_app/restaurant_screen/components/second_section.dart';
import 'package:out_app/restaurant_screen/components/third_section.dart';
import 'package:out_app/restaurant_screen/components/top_section.dart';

import 'components/restaurant_image.dart';

class RestaurantViewScreen extends StatelessWidget {
  const RestaurantViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFBFF),
        body: ListView(
          children: [
            const RestaurantViewImage(restaurantTitle: "Restaurant"),
            const RestaurantViewTopSection(
              address: '66 Bold Street, Liverpool, L1 4HR',
              price: 2,
              rating: 4,
              ratings: '2137',
              type: 'Italian',
            ),
            getSectionDivider(),
            const RestaurantViewSecondSection(
              tables: 5,
              stamps: 6,
            ),
            getSectionDivider(),
            const RestaurantViewThirdSection(
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                openingTime: "Sat-Sun 11:00 - 01:00"),
          ],
        ));
  }
}

Widget getSectionDivider() {
  return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Divider(
        indent: 15,
        endIndent: 15,
        thickness: 1,
      ));
}
