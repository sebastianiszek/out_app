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
    final CollectionReference _restaurantsCollection =
        FirebaseFirestore.instance.collection('Restaurants');

    return StreamBuilder<DocumentSnapshot>(
      stream: _restaurantsCollection.doc(widget.documentID).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              backgroundColor: const Color(0xFFFFFBFF),
              body: ListView(
                children: const [
                  BackButton(),
                  Text('Something went wrong...'),
                ],
              ));
        }

        if (snapshot.hasData) {
          final data = snapshot.requireData;
          return Scaffold(
              backgroundColor: const Color(0xFFFFFBFF),
              body: ListView(
                children: [
                  RestaurantViewImage(
                    restaurantTitle: data['name'],
                    restaurantID: data.id,
                    type: data['type'],
                    fileName: data['image'],
                  ),
                  RestaurantViewTopSection(
                    address: data['address'],
                    price: data['price'],
                    rating: data['rating'],
                    ratings: data['rating_count'].toString(),
                    type: data['type'],
                    location: data['location'],
                    restaurantID: data.id,
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
        }
        return const _LoadingScreen();
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

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFBFF),
        body: ListView(children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  color: Colors.transparent,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/placeholder.png')),
                ),
                height: 190.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.black45,
                      Colors.black.withAlpha(0),
                    ],
                  ),
                ),
                height: 190.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 5, 4, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 182),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 80),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFFFBFF),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Text(
                          'Loading...',
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
