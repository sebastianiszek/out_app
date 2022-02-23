import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/card_components/price.dart';

class SavedCardSubHead extends StatelessWidget {
  const SavedCardSubHead(
      {Key? key,
      required this.tables,
      required this.opened,
      required this.price,
      required this.type,
      required this.rating,
      required this.distance})
      : super(key: key);
  final int tables;
  final String opened;
  final int price;
  final String type;
  final double rating;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(text: type + '  •  ' + opened + '  '),
                      const WidgetSpan(
                        child: Icon(
                          Icons.table_rows_outlined,
                          size: 18,
                        ),
                      ),
                      TextSpan(text: ' ' + tables.toString()),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Icon(
                          Icons.near_me,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextSpan(text: distance),
                    ],
                  ),
                ),
              ])),
    ]);
  }
}
