import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DistanceText extends StatelessWidget {
  const DistanceText({Key? key, required this.location}) : super(key: key);
  final dynamic location;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator.getCurrentPosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic position = snapshot.data;
          double distanceInMeters = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              location.latitude,
              location.longitude);
          distanceInMeters = distanceInMeters / 1000;

          return RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: Icon(
                    Icons.near_me,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextSpan(text: getDistanceText(distanceInMeters) + ' km'),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

String getDistanceText(double distance) {
  if (distance < 1) {
    return distance.toStringAsFixed(1);
  }
  return distance.round().toString();
}
