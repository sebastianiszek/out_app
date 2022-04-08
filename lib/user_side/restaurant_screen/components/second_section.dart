import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/table_icon.dart';
import 'package:out_app/user_side/restaurant_screen/components/booking_button.dart';
import 'package:out_app/user_side/restaurant_screen/components/disabled_booking.dart';
import 'package:out_app/user_side/restaurant_screen/components/stamps_section.dart';

class RestaurantViewSecondSection extends StatelessWidget {
  const RestaurantViewSecondSection(
      {Key? key,
      required this.tables,
      required this.restaurantID,
      required this.opened})
      : super(key: key);

  final int tables;
  final String restaurantID;
  final bool opened;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutStampsSection(
          restaurantID: restaurantID,
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          stampsAlignment: MainAxisAlignment.spaceBetween,
          textAlignment: MainAxisAlignment.center,
        ),
        opened
            ? BookingButton(restaurantID: restaurantID, tables: tables)
            : const DisabledBookingButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTableIcon(tables, 24),
            Text(
              " " + tables.toString() + " Tables Available",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }
}
