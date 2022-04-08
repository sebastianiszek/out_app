import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:out_app/user_side/home_body/components/card_components/price.dart';
import 'package:out_app/user_side/restaurant_screen/components/top_section.dart';

class BusTopSection extends StatefulWidget {
  const BusTopSection({Key? key, required this.restaurantID}) : super(key: key);
  final String restaurantID;
  @override
  State<BusTopSection> createState() => _BusTopSectionState();
}

class _BusTopSectionState extends State<BusTopSection> {
  @override
  Widget build(BuildContext context) {
    DocumentReference restaurant = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(widget.restaurantID);

    return FutureBuilder<DocumentSnapshot>(
      future: restaurant.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Restaurant does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/placeholder.png',
                    ),
                  ),
                ),
                height: 190.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 182),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 80),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFFFBFF),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Text(
                              data['name'],
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                              data['type'] +
                                  " " +
                                  getPriceFromInt(data['price']),
                              style: Theme.of(context).textTheme.bodyText1),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...getList(5, data['rating']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              data['rating_count'].toString() + " Ratings",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.merge(const TextStyle(color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              data['address'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
