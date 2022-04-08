import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OutStampsSection extends StatefulWidget {
  const OutStampsSection(
      {Key? key,
      required this.restaurantID,
      required this.stampsAlignment,
      required this.padding,
      required this.textAlignment,
      this.userID = ''})
      : super(key: key);
  final String restaurantID;
  final MainAxisAlignment stampsAlignment;
  final MainAxisAlignment textAlignment;
  final EdgeInsets padding;
  final String userID;

  @override
  State<OutStampsSection> createState() => _OutStampsSectionState();
}

class _OutStampsSectionState extends State<OutStampsSection> {
  @override
  Widget build(BuildContext context) {
    String userID = widget.userID;
    if (userID.isEmpty) {
      userID = FirebaseAuth.instance.currentUser!.uid;
    }

    Stream<DocumentSnapshot> _stampsStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('stamps')
        .doc(widget.restaurantID)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _stampsStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 20,
                  ),
                  child: Padding(
                    padding: widget.padding,
                    child: Row(
                      mainAxisAlignment: widget.stampsAlignment,
                      children: [
                        ...getList(10, 0),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: widget.textAlignment,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                    child: Text(getDiscountText(0),
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              ),
            ],
          );
        }

        final data = snapshot.requireData;

        if (data.exists) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 55,
                  ),
                  child: Padding(
                    padding: widget.padding,
                    child: Row(
                      mainAxisAlignment: widget.stampsAlignment,
                      children: [
                        ...getList(10, data['stamps']),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: widget.textAlignment,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                    child: Text(getDiscountText(data['stamps']),
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              // Padding(
              // padding: widget.padding,
              // child:
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 20,
                  ),
                  child: Padding(
                    padding: widget.padding,
                    child: Row(
                      mainAxisAlignment: widget.stampsAlignment,
                      children: [
                        ...getList(10, 0),
                      ],
                    ),
                  ),
                ),
              ),
              // ),
              Row(
                mainAxisAlignment: widget.textAlignment,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                    child: Text(getDiscountText(0),
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              ),
            ],
          );
        }
      },
    );
  }
}

List<Widget> getList(int total, int quantity) {
  //red BA1B1B
  //blank 77767F

  if (quantity > 10) {
    quantity = 10;
  } else if (quantity < 0) {
    quantity = 0;
  }

  List<Widget> stars = [];
  for (var i = 0; i < quantity; i++) {
    stars.add(getIcon(false));
  }
  int remaining = total - quantity;
  if (remaining > 0) {
    for (var i = 0; i < remaining; i++) {
      stars.add(getIcon(true));
    }
  }
  return stars;
}

Icon getIcon(bool empty) {
  if (empty) {
    return const Icon(Icons.stars, color: Color(0xFF77767F), size: 24);
  } else {
    return const Icon(Icons.stars, color: Color(0xFFBA1B1B), size: 24);
  }
}

String getDiscountText(int quantity) {
  if (quantity > 10) {
    quantity = 10;
  } else if (quantity < 0) {
    quantity = 0;
  }

  if (quantity == 10) {
    return "£10 Discount Available";
  }

  quantity = 10 - quantity;

  return quantity.toString() + " More for a £10 Discount";
}
