import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';
import 'package:out_app/user_side/restaurant_screen/components/third_section.dart';

import '../../out_app_icons.dart';
import '../restaurant_screen/components/stamps_section.dart';

import 'components/booking_image.dart';

class BookingViewScreen extends StatefulWidget {
  const BookingViewScreen({Key? key, required this.documentID})
      : super(key: key);
  final String documentID;

  @override
  _BookingViewScreenState createState() => _BookingViewScreenState();
}

class _BookingViewScreenState extends State<BookingViewScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _restaurantsStream = FirebaseFirestore
        .instance
        .collection('Restaurants')
        .doc(widget.documentID)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _restaurantsStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              backgroundColor: const Color(0xFFFFFBFF),
              body: ListView(
                children: const [BackButton(), Text('Something went wrong. ')],
              ));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: const Color(0xFFFFFBFF),
              body: ListView(
                children: const [BackButton(), Text('Loading...')],
              ));
        }

        final data = snapshot.requireData;

        Color buttonColor = Theme.of(context).colorScheme.errorContainer;
        Color buttonTextColor = Theme.of(context).colorScheme.onErrorContainer;

        return Scaffold(
            backgroundColor: const Color(0xFFFFFBFF),
            body: ListView(
              children: [
                BookingViewImage(
                  restaurantTitle: data['name'],
                  restaurantID: data.id,
                  type: data['type'],
                  fileName: data['image'],
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFFFFBFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // RestaurantViewTopSection(
                //   address: data['address'],
                //   price: data['price'],
                //   rating: data['rating'],
                //   ratings: data['rating_count'].toString(),
                //   type: data['type'],
                // ),
                getSectionDivider(),
                Column(
                  children: [
                    OutStampsSection(
                      restaurantID: widget.documentID,
                      padding: const EdgeInsets.fromLTRB(34, 6, 34, 8),
                      stampsAlignment: MainAxisAlignment.spaceBetween,
                      textAlignment: MainAxisAlignment.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          showCupertinoDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Center(
                                        child: Text(
                                      'Cancel booking',
                                    )),
                                    content: const SizedBox(
                                      width: 300,
                                      child: Text(
                                        'Are you sure you want to cancel the booking?',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'No, Return',
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              'booking': '',
                                            });
                                            var list = [
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                            ];
                                            await FirebaseFirestore.instance
                                                .collection('Restaurants')
                                                .doc(widget.documentID)
                                                .update({
                                              'bookings':
                                                  FieldValue.arrayRemove(list),
                                              'tables': FieldValue.increment(1)
                                            });
                                            //Notify restaurant
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            outSnackbar(
                                                'Cancelled Booking', context);
                                          },
                                          child: Text(
                                            'Yes, Cancel Booking',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          )),
                                    ],
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))));
                              });
                        },
                        style: getOutButtonStyle(buttonColor).merge(ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: buttonTextColor)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(40, 18, 40, 18)))),
                        icon: Icon(
                          OutApp.logo,
                          color: buttonTextColor,
                        ),
                        label: Text(
                          "Cancel Booking",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.merge(TextStyle(color: buttonTextColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                getSectionDivider(),
                RestaurantViewThirdSection(
                    description: data['description'],
                    openingTime: data['opening_times'],
                    url: data['menu']),
              ],
            ));
      },
    );
  }
}

Widget getSectionDivider() {
  return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Divider(
        indent: 15,
        endIndent: 15,
        thickness: 1,
      ));
}
