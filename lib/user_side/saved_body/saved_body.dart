import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/input.dart';
import 'package:out_app/user_side/home_body/components/divider.dart';
import 'package:out_app/user_side/saved_body/components/saved_card.dart';

class SavedBody extends StatefulWidget {
  const SavedBody({Key? key}) : super(key: key);

  @override
  State<SavedBody> createState() => _SavedBodyState();
}

class _SavedBodyState extends State<SavedBody> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _restaurantsStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('saved')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _restaurantsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: TextFormField(
                    decoration: getOutInputDecoration(
                        const Color(0xFFDEE0FF), const Color(0xFF000965)),
                    onChanged: (String value) {}),
              ),
            ],
          );
        }

        final data = snapshot.requireData;

        return RestaurantList(data: data);
      },
    );
  }
}

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key, required this.data}) : super(key: key);
  final QuerySnapshot<Object?> data;

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<QueryDocumentSnapshot<Object?>> list = [];
  String name = '';

  void updateList(String name) {
    this.name = name;
    List<QueryDocumentSnapshot<Object?>> tempList = [];

    for (int i = 0; i < widget.data.size; i++) {
      if (name.isEmpty) {
        tempList = widget.data.docs;
        break;
      }
      if (widget.data.docs[i]['name'].toString().toUpperCase().contains(name)) {
        tempList.add(widget.data.docs[i]);
      }
    }

    if (list.length != tempList.length) {
      setState(() {
        list = tempList;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    list = widget.data.docs;
  }

  @override
  Widget build(BuildContext context) {
    updateList(name);
    if (widget.data.size == 0) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextFormField(
                decoration: getOutInputDecoration(
                    const Color(0xFFDEE0FF), const Color(0xFF000965)),
                onChanged: (String value) {}),
          ),
          const DividerPadding(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bookmark_add_outlined,
                  size: 42,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'No saved places yet',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Tap the bookmark icon while viewing a place\nto save it here.',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (list.isEmpty && name.isNotEmpty) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextFormField(
                decoration: getOutInputDecoration(
                    const Color(0xFFDEE0FF), const Color(0xFF000965)),
                onChanged: (String value) {
                  updateList(value.toUpperCase());
                }),
          ),
          const DividerPadding(),
          const Text(
            'No results',
            textAlign: TextAlign.center,
          )
        ],
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: TextFormField(
              decoration: getOutInputDecoration(
                  const Color(0xFFDEE0FF), const Color(0xFF000965)),
              onChanged: (String value) {
                updateList(value.toUpperCase());
              }),
        ),
        const DividerPadding(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return SavedCard(
              restaurant: list[index],
            );
          },
        )
      ],
    );
  }
}
