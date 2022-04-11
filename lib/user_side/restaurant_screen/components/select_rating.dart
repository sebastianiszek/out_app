import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';

class SelectRating extends StatefulWidget {
  const SelectRating({Key? key, required this.restaurantID}) : super(key: key);
  final String restaurantID;

  @override
  State<SelectRating> createState() => _SelectRatingState();
}

class _SelectRatingState extends State<SelectRating> {
  int rating = 5;

  void updateRating(int rating) {
    setState(() {
      this.rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    for (var i = 0; i < 5; i++) {
      Icon icon =
          const Icon(Icons.star, color: Color.fromARGB(255, 255, 193, 35));
      if (i > rating - 1) {
        icon =
            const Icon(Icons.star, color: Color.fromARGB(255, 142, 142, 149));
      }

      buttons.add(IconButton(
          onPressed: () {
            updateRating(i + 1);
          },
          splashRadius: 16.0,
          iconSize: 20,
          icon: icon));
    }

    return AlertDialog(
        title: const Text(
          'Rate the Restaurant',
          textAlign: TextAlign.center,
        ),
        content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [...buttons]),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.error),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);

                // Create a reference to the document the transaction will use
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection('Restaurants')
                    .doc(widget.restaurantID);

                FirebaseFirestore.instance.runTransaction((transaction) async {
                  // Get the document
                  DocumentSnapshot snapshot =
                      await transaction.get(documentReference);

                  if (!snapshot.exists) {
                    throw Exception("Restaurant does not exist!");
                  }

                  // Update the follower count based on the current count
                  // Note: this could be done without a transaction
                  // by updating the population using FieldValue.increment()

                  dynamic oldRating = await snapshot.get('rating');
                  int ratingCount = await snapshot.get('rating_count');

                  // Perform an update on the document
                  transaction.update(documentReference, {
                    'rating_count': ratingCount + 1,
                    'rating': calculateNewRating(oldRating, rating, ratingCount)
                  });

                  // Return the new count
                  // return newFollowerCount;
                }).then((value) async {
                  List list = [widget.restaurantID];
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .update({"rated": FieldValue.arrayUnion(list)})
                      .then((value) => outSnackbar('Rating updated.', context))
                      .onError((error, stackTrace) => outSnackbar(
                          'Error occurred, please try again.', context));
                }).catchError((error) => null);
              },
              child: const Text('Save')),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))));
  }
}

double calculateNewRating(
    dynamic oldRating, dynamic userRating, dynamic count) {
  return (oldRating * count + userRating) / (count + 1);
}
