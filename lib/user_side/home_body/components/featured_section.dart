import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/user_side/home_body/components/close_section.dart';

import 'card.dart';

class HomeFeaturedSection extends StatelessWidget {
  const HomeFeaturedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference restaurants =
        FirebaseFirestore.instance.collection('Restaurants');

    return FutureBuilder<QuerySnapshot>(
      future: restaurants.where('featured', isEqualTo: true).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("An error occurred.");
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var list = snapshot.data!.docs.toList();

          return SizedBox(
              height: 203.0,
              child: ListView.builder(
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                        child: RestaurantCard(
                          title: list[index]['name'],
                          tables: list[index]['tables'],
                          opened: list[index]['opened'],
                          price: list[index]['price'],
                          type: list[index]['type'],
                          rating: list[index]['rating'],
                          distance: '1',
                          restaurantID: list[index].id,
                          fileName: list[index]['image'],
                          location: list[index]['location'],
                        ));
                  }));
        }
        return SizedBox(
            height: 203.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (int index) {
                return const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                    child: RestaurantCard(
                      title: "Loading...",
                      tables: 0,
                      opened: false,
                      price: 1,
                      type: "Loading...",
                      rating: 5,
                      distance: "1",
                      restaurantID: 'e',
                      fileName: '',
                      location: null,
                    ));
              }),
            ));
      },
    );
  }
}
