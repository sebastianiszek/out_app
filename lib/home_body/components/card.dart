import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.0,
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
                      height: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            children: const [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.table_rows_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: ' 4  •  Opened Now'),
                                            ],
                                          ),
                                        )),
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 5),
                                        child: Text("££"))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ));
          }),
        ));
  }
}
