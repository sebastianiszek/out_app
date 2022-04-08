import 'package:flutter/material.dart';
import 'package:out_app/business_side/bookings_body/components/bookings_section.dart';
import 'package:out_app/business_side/bookings_body/components/free_tables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:out_app/business_side/bookings_body/components/tables_addsub.dart';

class BusBookingsBody extends StatefulWidget {
  const BusBookingsBody({Key? key, required this.restaurantID})
      : super(key: key);
  final String restaurantID;

  @override
  State<BusBookingsBody> createState() => _BusBookingsBodyState();
}

class _BusBookingsBodyState extends State<BusBookingsBody> {
  late String restaurantID;
  late final Stream<DocumentSnapshot> _restaurantStream = FirebaseFirestore
      .instance
      .collection('Restaurants')
      .doc(restaurantID)
      .snapshots();

  @override
  void initState() {
    restaurantID = widget.restaurantID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _restaurantStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong...');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        var list = [];

        try {
          list = snapshot.data!['bookings'];
        } catch (e) {
          null;
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          children: [
            FreeTables(tables: snapshot.data!['tables']),
            TablesAddSub(
              restaurantID: restaurantID,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Bookings',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            LoadBookingsSection(
              list: list,
              restaurantID: restaurantID,
            )
          ],
        );
      },
    );
  }
}

class LoadBookingsSection extends StatelessWidget {
  const LoadBookingsSection(
      {Key? key, required this.list, required this.restaurantID})
      : super(key: key);
  final List<dynamic> list;
  final String restaurantID;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return (const Text('No bookings'));
    }
    return BookingsSection(
      list: list,
      restaurantID: restaurantID,
    );
  }
}
