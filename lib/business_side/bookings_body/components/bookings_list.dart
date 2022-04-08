import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingsList extends StatefulWidget {
  const BookingsList({Key? key, required this.list}) : super(key: key);
  final List<QueryDocumentSnapshot> list;

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return ListTile(
          iconColor: Theme.of(context).colorScheme.primaryContainer,
          leading: const Icon(Icons.book_rounded),
          trailing: const Icon(Icons.arrow_right),
          title: Text(widget.list[index].get('email')),
          onTap: () {},
        );
      },
    );
  }
}
