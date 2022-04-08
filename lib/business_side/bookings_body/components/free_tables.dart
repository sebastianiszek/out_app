import 'package:flutter/material.dart';

class FreeTables extends StatelessWidget {
  const FreeTables({Key? key, required this.tables}) : super(key: key);
  final dynamic tables;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
          child: Column(
        children: [
          Text(
            tables.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.merge(const TextStyle(color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Free Tables',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.merge(const TextStyle(color: Colors.black)),
            ),
          ),
        ],
      )),
    );
    ;
  }
}
