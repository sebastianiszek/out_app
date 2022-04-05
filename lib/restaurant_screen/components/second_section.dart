import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/out_app_icons.dart';
import 'package:out_app/restaurant_screen/components/booking_button.dart';
import 'package:out_app/restaurant_screen/components/stamps_section.dart';
import 'package:out_app/shared_components/button.dart';
import 'package:out_app/shared_components/out_dialog.dart';
import 'package:out_app/shared_components/table_icon.dart';

import '../../shared_components/out_snackbar.dart';

class RestaurantViewSecondSection extends StatelessWidget {
  const RestaurantViewSecondSection(
      {Key? key, required this.tables, required this.restaurantID})
      : super(key: key);

  final int tables;
  final String restaurantID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutStampsSection(
          restaurantID: restaurantID,
          padding: const EdgeInsets.fromLTRB(34, 6, 34, 8),
          stampsAlignment: MainAxisAlignment.spaceBetween,
          textAlignment: MainAxisAlignment.center,
        ),
        BookingButton(restaurantID: restaurantID, tables: tables),
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
