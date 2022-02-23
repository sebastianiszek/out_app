import 'package:flutter/material.dart';
import 'package:out_app/search_body/components/search_card_header.dart';
import 'package:out_app/search_body/components/search_card_subhead.dart';
import 'package:out_app/shared_components/img_avatar.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
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
                          children: const [
                            //short text if it's too long
                            SearchCardHeader(title: "Restaurant"),
                            SearchCardSubHead(
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
            )));
  }
}
