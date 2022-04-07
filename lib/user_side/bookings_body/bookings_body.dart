import 'package:flutter/material.dart';
import 'package:out_app/user_side/bookings_body/components/current_booking.dart';
import 'package:out_app/user_side/bookings_body/components/past_bookings.dart';

class BookingsBody extends StatelessWidget {
  const BookingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text("Bookings",
              style: Theme.of(context).textTheme.headline4?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSurface))),
        ),
        const CurrentBooking(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text("Past",
              style: Theme.of(context).textTheme.headline6?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSurface))),
        ),
        const PastBookings(),
      ],
    );
  }
}
