import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OutSaveButtonLoad extends StatelessWidget {
  const OutSaveButtonLoad(
      {Key? key,
      required this.restaurantID,
      required this.name,
      required this.type})
      : super(key: key);
  final String restaurantID;
  final String name;
  final String type;

  @override
  Widget build(BuildContext context) {
    CollectionReference saved = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('saved');

    return FutureBuilder<DocumentSnapshot>(
      future: saved.doc(restaurantID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return OutSaveButton(
            name: name,
            restaurantID: restaurantID,
            type: type,
            saved: false,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return OutSaveButton(
            name: name,
            restaurantID: restaurantID,
            type: type,
            saved: true,
          );
        }

        return IconButton(
          iconSize: 32,
          onPressed: () {},
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
          ),
        );
        ;
      },
    );
  }
}

class OutSaveButton extends StatefulWidget {
  const OutSaveButton(
      {Key? key,
      required this.restaurantID,
      required this.name,
      required this.type,
      required this.saved})
      : super(key: key);
  final String restaurantID;
  final String name;
  final String type;
  final bool saved;

  @override
  State<OutSaveButton> createState() => _OutSaveButtonState();
}

class _OutSaveButtonState extends State<OutSaveButton> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.saved;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('saved');

    users.doc(widget.restaurantID).get().then((value) => null);

    Future<void> saveRestaurant() {
      return users
          .doc(widget.restaurantID)
          .set({'name': widget.name, 'type': widget.type}).catchError(
              (error) => print("Failed to add user: $error"));
    }

    Future<void> deleteSavedRestaurant() {
      return users
          .doc(widget.restaurantID)
          .delete()
          .catchError((error) => print("Failed to delete user: $error"));
    }

    void showSnackBar(String text) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            text,
            textAlign: TextAlign.center,
          ),
          duration: const Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }

    void _toggleSave() {
      setState(() {
        if (_isSaved) {
          showSnackBar('Removed from saved');
          _isSaved = false;
          deleteSavedRestaurant();
        } else {
          showSnackBar('Added to saved');
          _isSaved = true;
          saveRestaurant();
        }
      });
    }

    return IconButton(
      iconSize: 32,
      onPressed: () {
        _toggleSave();
      },
      icon: Icon(
        _isSaved ? Icons.bookmark_added : Icons.bookmark_add_outlined,
        color: Colors.white,
      ),
    );
  }
}
