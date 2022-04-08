import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/user_side/bookings_body/components/booking_card.dart';

class PastBookings extends StatefulWidget {
  const PastBookings({Key? key}) : super(key: key);

  @override
  State<PastBookings> createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {
  final Stream<QuerySnapshot> _bookingsStream = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('bookings')
      .limit(20)
      .orderBy('date', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bookingsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        if (snapshot.hasData) {
          if (snapshot.data!.size == 0) {
            return const Text('Your bookings will be listed here.');
          }

          return ListView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              if (data['restaurantID'] != null &&
                  data['name'] != null &&
                  data['type'] != null &&
                  data['rating'] != null &&
                  data['image'] != null) {
                return BookingCard(
                  restaurantID: data['restaurantID'],
                  name: data['name'],
                  type: data['type'],
                  rating: data['rating'],
                  fileName: data['image'],
                );
              }
              return Container();
            }).toList(),
          );
        }
        return const Text('Your past bookings will be listed here');
      },
    );
  }
}
