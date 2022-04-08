import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/business_side/booking_view_screen/booking_view_screen.dart';

class BookingsSection extends StatefulWidget {
  const BookingsSection(
      {Key? key, required this.list, required this.restaurantID})
      : super(key: key);
  final List<dynamic> list;
  final String restaurantID;

  @override
  State<BookingsSection> createState() => _BookingsSectionState();
}

class _BookingsSectionState extends State<BookingsSection> {
  late final Query _usersFuture;

  @override
  void initState() {
    _usersFuture = FirebaseFirestore.instance
        .collection('Users')
        .where(FieldPath.documentId, whereIn: widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _usersFuture.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.docs.isEmpty) {
            return const Text("Empty");
          }

          var list = snapshot.data!.docs.toList();

          return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  iconColor: Theme.of(context).colorScheme.primaryContainer,
                  leading: const Icon(Icons.book_rounded),
                  trailing: const Icon(Icons.arrow_right),
                  title: Text(list[index]['email']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusBookingViewScreen(
                          restaurantID: widget.restaurantID,
                          userID: list[index].id,
                          userEmail: list[index]['email'],
                        ),
                      ),
                    );
                  },
                );
              });
        }
        return const Text("Loading...");
      },
    );
  }
}
