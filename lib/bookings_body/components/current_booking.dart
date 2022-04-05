import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/bookings_body/components/current_card.dart';

class CurrentBooking extends StatefulWidget {
  const CurrentBooking({Key? key}) : super(key: key);

  @override
  State<CurrentBooking> createState() => _CurrentBookingState();
}

class _CurrentBookingState extends State<CurrentBooking> {
  final Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _userStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        try {
          String current = snapshot.requireData['booking'];
          if (current.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text("Current",
                      style: Theme.of(context).textTheme.headline6?.merge(
                          TextStyle(
                              color: Theme.of(context).colorScheme.onSurface))),
                ),
                CurrentCard(
                  restaurantId: current,
                ),
              ],
            );
          }
          return Container();
        } catch (e) {
          return Container();
        }
      },
    );
  }
}
