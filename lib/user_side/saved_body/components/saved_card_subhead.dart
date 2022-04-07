import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/table_icon.dart';

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
  final dynamic tables;
  final String opened;
  final dynamic price;
  final String type;
  final dynamic rating;
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
                      WidgetSpan(
                        child: getTableIcon(tables, 18),
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
