import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:out_app/user_side/distance_text.dart';
import 'package:out_app/user_side/home_body/components/card.dart';

class HomeCloseSection extends StatelessWidget {
  const HomeCloseSection({Key? key, required this.restaurants})
      : super(key: key);
  final List<QueryDocumentSnapshot> restaurants;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator.getCurrentPosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic position = snapshot.data;

          List<RestaurantObject> proximityList = [];

          for (var element in restaurants) {
            double distanceInMeters = Geolocator.distanceBetween(
                position.latitude,
                position.longitude,
                element['location'].latitude,
                element['location'].longitude);
            distanceInMeters = distanceInMeters / 1000;

            proximityList.add(RestaurantObject(distanceInMeters, element));
          }

          proximityList.sort((a, b) => a.proximity.compareTo(b.proximity));
          if (proximityList.length > 9) {
            proximityList = proximityList.sublist(0, 9);
          }

          return SizedBox(
              height: 203.0,
              child: ListView.builder(
                itemCount: proximityList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                      child: RestaurantCard(
                        title: proximityList[index].restaurant['name'],
                        tables: proximityList[index].restaurant['tables'],
                        opened: proximityList[index].restaurant['opened'],
                        price: proximityList[index].restaurant['price'],
                        type: proximityList[index].restaurant['type'],
                        rating: proximityList[index].restaurant['rating'],
                        restaurantID: proximityList[index].restaurant.id,
                        fileName: proximityList[index].restaurant['image'],
                        distance:
                            getDistanceText(proximityList[index].proximity),
                        location: null,
                      ));
                },
              ));
        }
        return Container();
      },
    );
  }
}

// children: List.generate(10, (int index) {
//           return const Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
//               child: RestaurantCard(
//                   title: "Restaurant",
//                   tables: 4,
//                   opened: "Opened Now",
//                   price: 2,
//                   type: "Italian",
//                   rating: 5,
//                   distance: "1 km"));
//         }),

class RestaurantObject {
  late double proximity;
  late QueryDocumentSnapshot restaurant;

  RestaurantObject(this.proximity, this.restaurant);
}
