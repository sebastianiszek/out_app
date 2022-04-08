import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:out_app/user_side/restaurant_screen/components/second_section.dart';
import 'package:out_app/user_side/restaurant_screen/components/third_section.dart';
import 'package:out_app/user_side/restaurant_screen/components/top_section.dart';

import 'components/restaurant_image.dart';

class RestaurantViewScreen extends StatefulWidget {
  const RestaurantViewScreen({Key? key, required this.documentID})
      : super(key: key);
  final String documentID;

  @override
  _RestaurantViewScreenState createState() => _RestaurantViewScreenState();
}

class _RestaurantViewScreenState extends State<RestaurantViewScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _restaurantsStream = FirebaseFirestore
        .instance
        .collection('Restaurants')
        .doc(widget.documentID)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _restaurantsStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              backgroundColor: Color(0xFFFFFBFF), body: Text('Loading...'));
        }

        final data = snapshot.requireData;

        return Scaffold(
            backgroundColor: const Color(0xFFFFFBFF),
            body: ListView(
              children: [
                RestaurantViewImage(
                  restaurantTitle: data['name'],
                  restaurantID: data.id,
                  type: data['type'],
                ),
                RestaurantViewTopSection(
                  address: data['address'],
                  price: data['price'],
                  rating: data['rating'],
                  ratings: data['rating_count'].toString(),
                  type: data['type'],
                ),
                getSectionDivider(),
                RestaurantViewSecondSection(
                  tables: data['tables'],
                  opened: data['opened'],
                  restaurantID: widget.documentID,
                ),
                getSectionDivider(),
                RestaurantViewThirdSection(
                    description: data['description'],
                    openingTime: "Sat-Sun 11:00 - 01:00"),
              ],
            ));
      },
    );
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
