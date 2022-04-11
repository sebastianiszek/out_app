import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/user_side/restaurant_screen/components/select_rating.dart';

class RatingButton extends StatefulWidget {
  const RatingButton({Key? key, required this.restaurantID}) : super(key: key);
  final String restaurantID;

  @override
  State<RatingButton> createState() => _RatingButtonState();
}

class _RatingButtonState extends State<RatingButton> {
  late Stream<DocumentSnapshot> restaurantStream = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  void handleRatingButtonPress() {}
  // bool isDialogOpened = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: restaurantStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // if (isDialogOpened) {
        //   Navigator.pop(context);
        //   isDialogOpened = false;
        // }
        if (snapshot.hasData) {
          List<dynamic> rated = [];
          try {
            rated = snapshot.data?.get('rated');
          } catch (e) {
            FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .update({'rated': rated}).onError((error, stackTrace) => null);
            return Container();
          }

          if (rated.contains(widget.restaurantID)) {
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: TextButton.icon(
              onPressed: () {
                // isDialogOpened = true;
                showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return SelectRating(
                        restaurantID: widget.restaurantID,
                      );
                    });
              },
              style: TextButton.styleFrom(primary: const Color(0xFFFFB800)),
              icon: const Icon(Icons.add, color: Color(0xFFFFB800)),
              label: Text(
                'Add a rating',
                style: Theme.of(context).textTheme.labelLarge?.merge(
                    const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
