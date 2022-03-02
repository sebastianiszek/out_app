import 'package:flutter/material.dart';
import 'package:out_app/out_app_icons.dart';
import 'package:out_app/shared_components/button.dart';
import 'package:out_app/shared_components/table_icon.dart';

class RestaurantViewSecondSection extends StatelessWidget {
  const RestaurantViewSecondSection(
      {Key? key, required this.stamps, required this.tables})
      : super(key: key);
  final int stamps;
  final int tables;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(34, 6, 34, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...getList(10, stamps),
            ],
          ),
        ),
        Text(
          getRemaining(stamps).toString() + " More for a £10 Discount",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: ElevatedButton.icon(
            style: getOutButtonStyle(const Color(0xFFEFE827)).merge(ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.black)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(40, 20, 40, 20)))),
            onPressed: () {},
            icon: const Icon(
              OutApp.logo,
              color: Colors.black,
            ),
            label: Text(
              "Book a Table",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTableIcon(tables, 24),
            Text(
              " 5 Tables Available",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }
}

List<Widget> getList(int total, int quantity) {
  //red BA1B1B
  //blank 77767F
  List<Widget> stars = [];
  for (var i = 0; i < quantity; i++) {
    stars.add(getIcon(false));
  }
  int remaining = total - quantity;
  if (remaining > 0) {
    for (var i = 0; i < remaining; i++) {
      stars.add(getIcon(true));
    }
  }
  return stars;
}

Icon getIcon(bool empty) {
  if (empty) {
    return const Icon(Icons.stars, color: Color(0xFF77767F), size: 24);
  } else {
    return const Icon(Icons.stars, color: Color(0xFFBA1B1B), size: 24);
  }
}

int getRemaining(int tables) {
  return 10 - tables;
}
