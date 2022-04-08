import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';

class BusinessCloseOpen extends StatefulWidget {
  const BusinessCloseOpen({Key? key, required this.restaurantID})
      : super(key: key);
  final String restaurantID;

  @override
  State<BusinessCloseOpen> createState() => _BusinessCloseOpenState();
}

class _BusinessCloseOpenState extends State<BusinessCloseOpen> {
  late Stream documentStream;

  @override
  void initState() {
    documentStream = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(widget.restaurantID)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: documentStream,
        initialData: const {'opened': false},
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong...');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          if (snapshot.data['opened'] == true) {
            return ElevatedButton(
              onPressed: () async {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                        title: const Center(
                            child: Text(
                          'Close Restaurant',
                        )),
                        content: const Text(
                          'Are you sure you want to close the restaurant?',
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                outSnackbar('Restaurant Closed', context);
                                FirebaseFirestore.instance
                                    .collection('Restaurants')
                                    .doc(widget.restaurantID)
                                    .update({'opened': false});
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    color:
                                        (Theme.of(context).colorScheme.error)),
                              ))
                        ],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))));
                  },
                );
              },
              child: const Text('Close Restaurant'),
              style: getOutButtonStyle(Colors.amber.shade700).merge(ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(180, 50)))),
            );
          } else {
            return ElevatedButton(
              onPressed: () async {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                        title: const Center(
                            child: Text(
                          'Open Restaurant',
                        )),
                        content: const Text(
                          'Are you sure you want to open the restaurant?',
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                outSnackbar('Restaurant Opened', context);
                                FirebaseFirestore.instance
                                    .collection('Restaurants')
                                    .doc(widget.restaurantID)
                                    .update({'opened': true});
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Open',
                                style: TextStyle(color: (Colors.green)),
                              ))
                        ],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))));
                  },
                );
              },
              child: const Text('Open Restaurant'),
              style: getOutButtonStyle(Colors.green).merge(ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(180, 50)))),
            );
          }
        });
  }
}
