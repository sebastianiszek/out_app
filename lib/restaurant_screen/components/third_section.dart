import 'package:flutter/material.dart';
import 'package:out_app/shared_components/button.dart';

class RestaurantViewThirdSection extends StatelessWidget {
  const RestaurantViewThirdSection(
      {Key? key, required this.description, required this.openingTime})
      : super(key: key);
  final String description;
  final String openingTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 7, 15, 30),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          "Opening Times",
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 7, 15, 30),
          child: Text(
            openingTime,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          "Menu",
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
          child: ElevatedButton(
              style: getOutButtonStyle(Theme.of(context).colorScheme.primary)
                  .merge(ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(50, 20, 50, 20)))),
              onPressed: () {},
              child: const Text("View")),
        ),
      ],
    );
  }
}
