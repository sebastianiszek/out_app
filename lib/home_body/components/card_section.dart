import 'package:flutter/material.dart';

import 'card.dart';

class HomeCardSection extends StatelessWidget {
  const HomeCardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 203.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (int index) {
            return const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                child: RestaurantCard(
                    title: "Restaurant",
                    tables: 4,
                    opened: "Opened Now",
                    price: 2,
                    type: "Italian",
                    rating: 5,
                    distance: "1 km"));
          }),
        ));
  }
}
