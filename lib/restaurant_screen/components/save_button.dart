import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OutSaveButtonLoad extends StatelessWidget {
  const OutSaveButtonLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}

class OutSaveButton extends StatefulWidget {
  const OutSaveButton(
      {Key? key,
      required this.restaurantID,
      required this.name,
      required this.type})
      : super(key: key);
  final String restaurantID;
  final String name;
  final String type;

  @override
  State<OutSaveButton> createState() => _OutSaveButtonState();
}

class _OutSaveButtonState extends State<OutSaveButton> {
  bool _isSaved = false;

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

    void _toggleSave() {
      setState(() {
        if (_isSaved) {
          _isSaved = false;
          deleteSavedRestaurant();
        } else {
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
