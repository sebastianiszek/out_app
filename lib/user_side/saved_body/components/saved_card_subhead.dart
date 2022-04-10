import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/functions.dart';
import 'package:out_app/shared/shared_components/table_icon.dart';
import 'package:out_app/user_side/distance_text.dart';

class SavedCardSubHead extends StatelessWidget {
  const SavedCardSubHead(
      {Key? key,
      required this.tables,
      required this.opened,
      required this.price,
      required this.type,
      required this.rating,
      required this.location})
      : super(key: key);
  final dynamic tables;
  final bool opened;
  final dynamic price;
  final String type;
  final dynamic rating;
  final dynamic location;

  @override
  Widget build(BuildContext context) {
    TextStyle openedStyle = getOpenedBulletStyle(opened);

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
                      TextSpan(text: type),
                      TextSpan(text: '  •  ', style: openedStyle),
                      getOpenedTextFormatted(opened),
                      const TextSpan(text: '  '),
                      WidgetSpan(
                        child: getTableIcon(tables, 18),
                      ),
                      TextSpan(text: ' ' + tables.toString()),
                    ],
                  ),
                ),
                DistanceText(location: location)
              ])),
    ]);
  }
}
