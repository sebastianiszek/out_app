import 'package:flutter/material.dart';
import 'package:out_app/bookings_body/components/booking_card.dart';

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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text("Current",
              style: Theme.of(context).textTheme.headline6?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSurface))),
        ),
        const BookingCard(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text("Past",
              style: Theme.of(context).textTheme.headline6?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSurface))),
        ),
        const BookingCard(),
      ],
    );
  }
}
