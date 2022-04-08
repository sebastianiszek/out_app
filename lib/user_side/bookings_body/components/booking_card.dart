import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/img_avatar.dart';

import '../../restaurant_screen/restaurant_screen.dart';
import '../../search_body/components/search_card_header.dart';
import 'bookings_card_subhead.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(
      {Key? key,
      required this.restaurantID,
      required this.type,
      this.rating,
      required this.name,
      required this.fileName})
      : super(key: key);
  final String restaurantID;
  final String name;
  final String type;
  final dynamic rating;
  final String fileName;

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => RestaurantViewScreen(
                    documentID: restaurantID,
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
                      fileName: fileName,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Column(
                              children: [
                                //short text if it's too long
                                SearchCardHeader(title: name),
                                BookingsCardSubhead(type: type, rating: rating),
                              ],
                            )),
                      ],
                    ))
                  ],
                ))));
  }
}
