import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/divider.dart';
import 'package:out_app/search_body/components/search_card.dart';
import 'package:out_app/shared_components/button.dart';
import 'package:out_app/shared_components/input.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _restaurantsStream = FirebaseFirestore.instance
        .collection('Restaurants')
        .where('name')
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

    return ListView(children: [
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
          return SearchCard(
            restaurant: list[index],
          );
          // ListTile(
          //   leading: const Icon(
          //     Icons.movie,
          //     color: Colors.teal,
          //   ),
          //   title: Text(list[index]['name']),
          //   trailing: const Icon(Icons.arrow_forward),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => MediaDetailScreen(media: list[index]),
          //     //   ),
          //     // );
          //   },
          // );
        },
      )
    ]);
  }
}

        // Padding(
        //   padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        //   child: TextFormField(
        //     decoration: getOutInputDecoration(
        //         const Color(0xFFDEE0FF), const Color(0xFF000965)),
        //   ),
        // ),

// const SearchCard(),


// ****   button   ****

// Padding(
//             padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
//             child: ElevatedButton(
//                 onPressed: () {
//                   // Respond to button press
//                 },
//                 style:
//                     getOutButtonStyle(Theme.of(context).colorScheme.secondary),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Text('Notify me of offers',
//                       style: Theme.of(context).textTheme.bodyText1),
//                 )))