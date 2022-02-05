import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/card_components/card_image.dart';
import 'package:out_app/home_body/components/card_components/header.dart';
import 'package:out_app/home_body/components/card_components/subhead.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 203.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (int index) {
            return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                child: Card(
                  color: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
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
                ));
          }),
        ));
  }
}
