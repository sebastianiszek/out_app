import 'package:flutter/material.dart';

class BookingsCardSubhead extends StatelessWidget {
  const BookingsCardSubhead(
      {Key? key,
      required this.type,
      required this.rating,
      required this.distance})
      : super(key: key);
  final String type;
  final double rating;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.merge(const TextStyle(height: 1)),
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
              )
            ],
          ))
    ]);
  }
}
