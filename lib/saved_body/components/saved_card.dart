import 'package:flutter/material.dart';
import 'package:out_app/saved_body/components/saved_card_header.dart';
import 'package:out_app/saved_body/components/saved_card_subhead.dart';
import 'package:out_app/search_body/components/search_card_header.dart';
import 'package:out_app/search_body/components/search_card_subhead.dart';
import 'package:out_app/shared_components/img_avatar.dart';

class SavedCard extends StatelessWidget {
  const SavedCard({Key? key}) : super(key: key);

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
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                restaurantAvatar(44, 44),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                        child: Column(
                          children: const [
                            //short text if it's too long
                            SavedCardHeader(title: "Restaurant"),
                            SavedCardSubHead(
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
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [...getList(7)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: Text("2 More for a £10 Discount",
                      style: Theme.of(context).textTheme.bodyText1),
                )
              ],
            )
          ])),
    );
  }
}

List<Widget> getList(int number) {
  //red BA1B1B
  //blank 77767F
  List<Widget> stars = [];
  for (var i = 0; i < number; i++) {
    stars.add(const Icon(
      Icons.stars,
      color: Color(0xFFBA1B1B),
    ));
  }
  int remaining = 10 - number;
  if (remaining > 0) {
    for (var i = 0; i < remaining; i++) {
      stars.add(const Icon(
        Icons.stars,
        color: Color(0xFF77767F),
      ));
    }
  }
  return stars;
}
