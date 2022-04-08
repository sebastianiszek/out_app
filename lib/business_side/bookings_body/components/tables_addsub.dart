import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';

class TablesAddSub extends StatefulWidget {
  const TablesAddSub({Key? key, required this.restaurantID}) : super(key: key);
  final String restaurantID;

  @override
  State<TablesAddSub> createState() => _TablesAddSubState();
}

class _TablesAddSubState extends State<TablesAddSub> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      child: Wrap(
        verticalDirection: VerticalDirection.up,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () async {
                FirebaseFirestore _firestore = FirebaseFirestore.instance;
                await _firestore.runTransaction((transaction) async {
                  DocumentReference resRef = _firestore
                      .collection('Restaurants')
                      .doc(widget.restaurantID);

                  DocumentSnapshot resSnap = await transaction.get(resRef);

                  if (resSnap['tables'] > 0) {
                    transaction
                        .update(resRef, {'tables': FieldValue.increment(-1)});
                    outSnackbar('Removed a table', context);
                  } else {
                    outSnackbar("Can't go below 0", context);
                  }
                });
              },
              child: const Text('Remove'),
              style: getOutButtonStyle(Colors.red).merge(ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(150, 55)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () async {
                outSnackbar('Adding a table', context);
                FirebaseFirestore _firestore = FirebaseFirestore.instance;

                _firestore
                    .collection('Restaurants')
                    .doc(widget.restaurantID)
                    .update({'tables': FieldValue.increment(1)}).onError(
                        (error, stackTrace) => outSnackbar('Error', context));
                outSnackbar('Added a table', context);
              },
              child: const Text('Add'),
              style: getOutButtonStyle(Colors.green).merge(ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(150, 55)))),
            ),
          ),
        ],
      ),
    );
  }
}
