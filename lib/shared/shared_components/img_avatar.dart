import 'package:flutter/material.dart';

class RestaurantAvatar extends StatelessWidget {
  const RestaurantAvatar(
      {Key? key, this.width, this.height, this.fileName = ''})
      : super(key: key);
  final dynamic width;
  final dynamic height;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    if (fileName.isEmpty) {
      return SizedBox(
          height: height.toDouble(),
          width: width.toDouble(),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/placeholder.png',
                ),
              )));
    }
    // Points to the root reference

    return SizedBox(
        height: height.toDouble(),
        width: width.toDouble(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FittedBox(
                fit: BoxFit.fitHeight,
                clipBehavior: Clip.hardEdge,
                child: Image(image: NetworkImage(fileName))
                // FirebaseImage(location),
                // Image.network(
                //   fileName,
                // ),
                )));
  }
}
