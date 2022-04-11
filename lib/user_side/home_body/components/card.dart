import 'package:flutter/material.dart';
import 'package:out_app/user_side/home_body/components/card_components/card_image.dart';
import 'package:out_app/user_side/home_body/components/card_components/header.dart';
import 'package:out_app/user_side/home_body/components/card_components/subhead.dart';

import 'package:out_app/user_side/restaurant_screen/restaurant_screen.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {Key? key,
      required this.title,
      required this.tables,
      required this.opened,
      required this.price,
      required this.type,
      required this.rating,
      required this.distance,
      required this.restaurantID,
      required this.fileName,
      required this.location})
      : super(key: key);
  final String title;
  final int tables;
  final bool opened;
  final int price;
  final String type;
  final dynamic rating;
  final dynamic distance;
  final String restaurantID;
  final String fileName;
  final dynamic location;

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
              builder: (context) => RestaurantViewScreen(
                documentID: restaurantID,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //short text if it's too long
                      RestaurantCardHeader(title: title),
                      RestaurantCardSubHead(
                        tables: tables,
                        opened: opened,
                        price: price,
                        type: type,
                        rating: rating,
                        distance: distance,
                        location: location,
                      ),
                    ],
                  ),
                ),
                RestaurantCardImage(
                  fileName: fileName,
                ),
              ],
            )),
      ),
    );
  }
}
