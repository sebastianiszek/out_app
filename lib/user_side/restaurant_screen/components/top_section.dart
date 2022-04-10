import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';
import 'package:out_app/user_side/home_body/components/card_components/price.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantViewTopSection extends StatelessWidget {
  const RestaurantViewTopSection(
      {Key? key,
      required this.type,
      required this.rating,
      required this.ratings,
      required this.address,
      required this.price,
      required this.location})
      : super(key: key);
  final String type;
  final int price;
  final int rating;
  final String ratings;
  final String address;
  final GeoPoint location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(type + " " + getPriceFromInt(price),
            style: Theme.of(context).textTheme.bodyText1),
        // Rating
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...getList(5, rating),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            ratings + " Ratings",
            style: Theme.of(context)
                .textTheme
                .caption
                ?.merge(const TextStyle(color: Colors.black)),
          ),
        ),
        TextButton.icon(
          onPressed: () async {
            Position currentLocation = await Geolocator.getCurrentPosition();
            String url = 'https://www.google.com/maps/dir/?api=1&origin=' +
                currentLocation.latitude.toString() +
                ',' +
                currentLocation.longitude.toString() +
                ' &destination=' +
                location.latitude.toString() +
                ',' +
                location.longitude.toString() +
                '&travelmode=driving&dir_action=navigate';

            try {
              _launchURL(url);
            } catch (e) {
              outSnackbar('Could not open the directions', context);
            }
          },
          icon: const Icon(Icons.directions),
          label: Text(
            address,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );
  }
}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

List<Widget> getList(int total, int quantity) {
  //red BA1B1B
  //blank 77767F
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
    return const Icon(Icons.star, color: Color(0xFFC3C4CF), size: 16);
  } else {
    return const Icon(Icons.star, color: Color(0xFFFFB800), size: 16);
  }
}
