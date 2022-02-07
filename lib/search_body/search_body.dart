import 'package:flutter/material.dart';
import 'package:out_app/shared_components/button.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(15),
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
