import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared_components/img_avatar.dart';
import '../../booking_screen/booking_screen.dart';
import '../../search_body/components/search_card_header.dart';
import 'bookings_card_subhead.dart';

class CurrentCard extends StatelessWidget {
  const CurrentCard({Key? key, required this.restaurantId}) : super(key: key);
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    DocumentReference restaurant =
        FirebaseFirestore.instance.collection('Restaurants').doc(restaurantId);

    return FutureBuilder<DocumentSnapshot>(
      future: restaurant.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong...');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Restaurant doesn't exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Card(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingViewScreen(
                          documentID: restaurantId,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RestaurantAvatar(
                            width: 44,
                            height: 44,
                            fileName: data['image'],
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 4, 0, 0),
                                  child: Column(
                                    children: [
                                      //short text if it's too long
                                      SearchCardHeader(title: data['name']),
                                      BookingsCardSubhead(
                                        type: data['type'],
                                        rating: data['rating'],
                                      ),
                                    ],
                                  )),
                            ],
                          ))
                        ],
                      ))));
        }

        return Card(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 22),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const RestaurantAvatar(width: 44, height: 44),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Column(
                              children: const [
                                //short text if it's too long
                                SearchCardHeader(title: 'Loading...'),
                                BookingsCardSubhead(
                                  type: 'Loading...',
                                  rating: 0,
                                ),
                              ],
                            )),
                      ],
                    ))
                  ],
                )));
      },
    );
  }
}
