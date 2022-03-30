import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/card_components/card_image.dart';
import 'package:out_app/home_body/components/card_components/header.dart';
import 'package:out_app/home_body/components/card_components/subhead.dart';
import 'package:out_app/restaurant_screen/restaurant_screen.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {Key? key,
      required this.title,
      required this.tables,
      required this.opened,
      required this.price,
      required this.type,
      required this.rating,
      required this.distance})
      : super(key: key);
  final String title;
  final int tables;
  final String opened;
  final int price;
  final String type;
  final double rating;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RestaurantViewScreen(
                documentID: 'ovT5HCJ1dRJwhFkebQRU',
              ),
            ),
          );
        },
        child: SizedBox(
            width: 225.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 2),
                  child: Column(
                    children: [
                      //short text if it's too long
                      RestaurantCardHeader(title: title),
                      const RestaurantCardSubHead(
                          tables: 4,
                          opened: "Opened Now",
                          price: 2,
                          type: "Italian",
                          rating: 5,
                          distance: "1 km"),
                    ],
                  ),
                ),
                const RestaurantCardImage(),
              ],
            )),
      ),
    );
  }
}
