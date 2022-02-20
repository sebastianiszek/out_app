import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/card_components/header.dart';
import 'package:out_app/home_body/components/card_components/price.dart';
import 'package:out_app/home_body/components/card_components/subhead.dart';
import 'package:out_app/home_body/components/divider.dart';
import 'package:out_app/shared_components/button.dart';
import 'package:out_app/shared_components/img_avatar.dart';
import 'package:out_app/shared_components/input.dart';
import 'package:out_app/shared_components/restaurant_tables_head.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: TextFormField(
            decoration: getOutInputDecoration(
                const Color(0xFFDEE0FF), const Color(0xFF000965)),
          ),
        ),
        const DividerPadding(),
        Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    restaurantAvatar(70, 70),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              children: const [
                                //short text if it's too long
                                RestaurantCardHeader(title: "Restaurant"),
                                RestaurantCardSubHead(
                                    tables: 4,
                                    opened: "Opened Now",
                                    price: 2,
                                    type: "Italian",
                                    rating: 5,
                                    distance: "1 km"),
                              ],
                            )),
                      ],
                    ))
                  ],
                ))),
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                style:
                    getOutButtonStyle(Theme.of(context).colorScheme.secondary),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Notify me of offers',
                      style: Theme.of(context).textTheme.bodyText1),
                )))
      ],
    );
  }
}
