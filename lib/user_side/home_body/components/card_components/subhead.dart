import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/functions.dart';
import 'package:out_app/user_side/distance_text.dart';
import 'package:out_app/user_side/home_body/components/card_components/price.dart';

import '../../../../shared/shared_components/table_icon.dart';

class RestaurantCardSubHead extends StatelessWidget {
  const RestaurantCardSubHead(
      {Key? key,
      required this.tables,
      required this.opened,
      required this.price,
      required this.type,
      required this.rating,
      required this.distance,
      required this.location})
      : super(key: key);
  final int tables;
  final bool opened;
  final int price;
  final String type;
  final dynamic rating;
  final dynamic distance;
  final dynamic location;

  @override
  Widget build(BuildContext context) {
    TextStyle openedStyle = getOpenedBulletStyle(opened);
    Widget distanceWidget;
    if (location != null) {
      distanceWidget = DistanceText(
        location: location,
      );
    } else {
      distanceWidget = RichText(
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
            TextSpan(text: ' ' + distance + ' km'),
          ],
        ),
      );
    }

    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 5),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      WidgetSpan(
                        child: getTableIcon(tables.round(), 20),
                      ),
                      TextSpan(
                        text: ' ' + tables.toString(),
                      ),
                      TextSpan(text: '  •  ', style: openedStyle),
                      getOpenedTextFormatted(opened)
                    ],
                  ),
                ),
                Text(getPriceFromInt(price)),
              ])),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(text: type + "  "),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.top,
                      child: Icon(
                        Icons.star,
                        size: 16,
                        color: Color(0xFFFFB800),
                      ),
                    ),
                    TextSpan(text: " " + rating.toString()),
                  ],
                ),
              ),
              distanceWidget,
            ],
          ))
    ]);
  }
}
