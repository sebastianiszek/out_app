import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/img_avatar.dart';
import 'package:out_app/user_side/restaurant_screen/components/stamps_section.dart';
import 'package:out_app/user_side/saved_body/components/saved_card_header.dart';
import 'package:out_app/user_side/saved_body/components/saved_card_subhead.dart';

import '../../restaurant_screen/restaurant_screen.dart';

class SavedCard extends StatefulWidget {
  const SavedCard({Key? key, required this.restaurant}) : super(key: key);
  final QueryDocumentSnapshot<Object?> restaurant;
  @override
  State<SavedCard> createState() => _SavedCardState();
}

class _SavedCardState extends State<SavedCard> {
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _restaurantStream = FirebaseFirestore
        .instance
        .collection('Restaurants')
        .doc(widget.restaurant.id)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _restaurantStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        final data = snapshot.requireData;

        if (!data.exists) {
          return Container();
        } else {
          return Card(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantViewScreen(
                        documentID: data.id,
                      ),
                    ),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                    child: Column(children: <Widget>[
                      Row(
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
                                      const EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  child: Column(
                                    children: [
                                      //short text if it's too long
                                      SavedCardHeader(
                                          title: widget.restaurant['name']),
                                      SavedCardSubHead(
                                          tables: data['tables'],
                                          opened: data['opened'],
                                          price: data['price'],
                                          type: data['type'],
                                          rating: data['rating'],
                                          distance: "1 km"),
                                    ],
                                  )),
                            ],
                          ))
                        ],
                      ),
                      const Divider(),
                      OutStampsSection(
                        restaurantID: data.id,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        stampsAlignment: MainAxisAlignment.spaceBetween,
                        textAlignment: MainAxisAlignment.end,
                      )
                    ])),
              ));
        }
      },
    );
  }
}
