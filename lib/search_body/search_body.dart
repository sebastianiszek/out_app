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
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Card(
            color: Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                      child: Row(
                    children: [
                      restaurantAvatar(70, 70),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rests',
                            style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Expanded(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  RichText(
                                    text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      children: [
                                        const WidgetSpan(
                                          child: Icon(
                                            Icons.table_rows_outlined,
                                            size: 20,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                ' ' + "4" + '  •  ' + "opened"),
                                      ],
                                    ),
                                  ),
                                  Text(getPriceFromInt(2)),
                                ])),
                          )
                        ],
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
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
