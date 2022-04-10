import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/input.dart';
import 'package:out_app/user_side/home_body/components/divider.dart';
import 'package:out_app/user_side/search_body/components/filter_dialog_body.dart';
import 'package:out_app/user_side/search_body/components/search_card.dart';

import '../search_body/components/top_section.dart';

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
        .where('opened', isNotEqualTo: false)
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
  String name = '';
  // price1, price2, price3, tables
  List<bool> filters = [true, true, true, false];

  void resetFilters() {
    setState(() {
      filters = [true, true, true, false];
    });
  }

  void setFilters(newFilters) {
    setState(() {
      filters = newFilters;
    });
  }

  void showFilterDialog(List<bool> currentFilters) async {
    // price1, price2, price3, tables
    List<bool> copiedFilters = List.from(currentFilters);

    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: const Center(
                  child: Text(
                'Filter',
              )),
              contentPadding: const EdgeInsets.only(top: 15),
              content: SingleChildScrollView(
                child: FilterDialogBody(
                  priceFilter: copiedFilters,
                  onFilterChanged: (value) {
                    copiedFilters = value;
                  },
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      resetFilters();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Clear Filters',
                      style: TextStyle(
                          color: (Theme.of(context).colorScheme.error)),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      setFilters(copiedFilters);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          color: (Theme.of(context).colorScheme.primary)),
                    ))
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))));
        });
  }

  bool isPriceFiltered(List<bool> filters, int price) {
    if (price == 1 && filters[0]) {
      return false;
    } else if (price == 2 && filters[1]) {
      return false;
    } else if (price == 3 && filters[2]) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<Object?>> list = [];

    if (name.isEmpty == true && filters == [true, true, true, false]) {
      list = widget.data.docs;
    } else {
      for (int i = 0; i < widget.data.size; i++) {
        if (widget.data.docs[i]['name']
            .toString()
            .toUpperCase()
            .contains(name)) {
          int price = widget.data.docs[i]['price'];
          int tables = widget.data.docs[i]['tables'];

          if (filters[3]) {
            if (tables > 0) {
              if (!isPriceFiltered(filters, price)) {
                list.add(widget.data.docs[i]);
              }
            }
          } else {
            if (!isPriceFiltered(filters, price)) {
              list.add(widget.data.docs[i]);
            }
          }
          if (widget.data.docs[i]['price'] == 3) {}
        }
      }
    }

    if (list.isEmpty) {
      return ListView(
        children: [
          TopSection(
            onSearchValueChanged: (value) {
              setState(() {
                name = value.toUpperCase();
              });
            },
            onFilterPressed: () {
              showFilterDialog(filters);
            },
          ),
          const DividerPadding(),
          const Text(
            'No results',
            textAlign: TextAlign.center,
          )
        ],
      );
    }

    return ListView(children: [
      TopSection(
        onSearchValueChanged: (value) {
          setState(() {
            name = value.toUpperCase();
          });
        },
        onFilterPressed: () {
          showFilterDialog(filters);
        },
      ),
      const DividerPadding(),
      ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return SearchCard(
            restaurant: list[index],
          );
        },
      ),
    ]);
  }
}



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