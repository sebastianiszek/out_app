import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/restaurant_screen/restaurant_screen.dart';
import 'package:out_app/search_body/components/search_card_header.dart';
import 'package:out_app/search_body/components/search_card_subhead.dart';
import 'package:out_app/shared_components/img_avatar.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({Key? key, required this.restaurant}) : super(key: key);

  final QueryDocumentSnapshot<Object?> restaurant;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Theme.of(context).colorScheme.background,

        // ******* CONTAINER DECORATION *******
        //
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15.0),
        //   color: Theme.of(context).colorScheme.background,
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.3),
        //       spreadRadius: 1,
        //       blurRadius: 2,
        //       offset: const Offset(0, 1), // changes position of shadow
        //     ),
        //   ],
        // ),

        child: InkWell(
            borderRadius: BorderRadius.circular(15.0),

            // NAVIGATE

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RestaurantViewScreen(),
                ),
              );
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    restaurantAvatar(66, 66),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Column(
                              children: [
                                //short text if it's too long
                                SearchCardHeader(title: restaurant['name']),
                                SearchCardSubHead(
                                    tables: restaurant['tables'],
                                    opened: "Opened Now",
                                    price: restaurant['price'],
                                    type: restaurant['type'],
                                    rating: restaurant['rating'],
                                    distance: "1 km"),
                              ],
                            )),
                      ],
                    ))
                  ],
                ))));
  }
}
