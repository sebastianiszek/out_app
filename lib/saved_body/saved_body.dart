import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/divider.dart';
import 'package:out_app/saved_body/components/saved_card.dart';
import 'package:out_app/shared_components/input.dart';

// class SavedBody extends StatelessWidget {
//   const SavedBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//           child: TextFormField(
//             decoration: getOutInputDecoration(
//                 const Color(0xFFDEE0FF), const Color(0xFF000965)),
//           ),
//         ),
//         const DividerPadding(),
//         const SavedCard(),
//       ],
//     );
//   }
// }

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
          return const Text("Loading..");
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
  String name = '';

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<Object?>> list = [];

    for (int i = 0; i < widget.data.size; i++) {
      if (name.isEmpty) {
        list = widget.data.docs;
        break;
      }
      if (widget.data.docs[i]['name'].toString().toUpperCase().contains(name)) {
        list.add(widget.data.docs[i]);
      }
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: TextFormField(
              decoration: getOutInputDecoration(
                  const Color(0xFFDEE0FF), const Color(0xFF000965)),
              onChanged: (String value) {
                setState(() {
                  name = value.toUpperCase();
                });
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
