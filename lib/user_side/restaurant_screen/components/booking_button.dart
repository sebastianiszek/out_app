import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/out_app_icons.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';

class BookingButton extends StatelessWidget {
  const BookingButton(
      {Key? key, required this.restaurantID, required this.tables})
      : super(key: key);
  final String restaurantID;
  final int tables;

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFFEFE827);
    Color buttonTextColor = Colors.black;

    if (tables <= 0) {
      buttonColor = ThemeData.light().disabledColor;
      buttonTextColor = Colors.black54;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (tables > 0) {
            showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                      title: const Center(
                          child: Text(
                        'Book a table',
                      )),
                      content: const Text('Do you want to make a booking?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            )),
                        TextButton(
                            onPressed: () async {
                              FirebaseFirestore _firestore =
                                  FirebaseFirestore.instance;
                              await _firestore
                                  .runTransaction((transaction) async {
                                DocumentReference accRef = _firestore
                                    .collection('Users')
                                    .doc(
                                        FirebaseAuth.instance.currentUser?.uid);
                                DocumentReference resRef = _firestore
                                    .collection('Restaurants')
                                    .doc(restaurantID);

                                DocumentSnapshot accSnap =
                                    await transaction.get(accRef);
                                DocumentSnapshot resSnap =
                                    await transaction.get(resRef);

                                if (resSnap['tables'] > 0) {
                                  if (accSnap['booking']
                                      .toString()
                                      .isNotEmpty) {
                                    outSnackbar(
                                        'You already have a booking', context);
                                  } else {
                                    var list = [
                                      FirebaseAuth.instance.currentUser?.uid
                                    ];
                                    transaction.update(
                                        accRef, {'booking': restaurantID});
                                    transaction.update(resRef, {
                                      'bookings': FieldValue.arrayUnion(list),
                                      'tables': FieldValue.increment(-1)
                                    });
                                    outSnackbar('Booking successful', context);
                                  }
                                } else {
                                  outSnackbar('No tables available', context);
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Book',
                            ))
                      ],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))));
                });
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'No available tables',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.merge(const TextStyle(color: Colors.white)),
            )));
          }
        },
        style: getOutButtonStyle(buttonColor).merge(ButtonStyle(
            textStyle:
                MaterialStateProperty.all(TextStyle(color: buttonTextColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(40, 18, 40, 18)))),
        icon: Icon(
          OutApp.logo,
          color: buttonTextColor,
        ),
        label: Text(
          "Book a Table",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.merge(TextStyle(color: buttonTextColor)),
        ),
      ),
    );
  }
}
