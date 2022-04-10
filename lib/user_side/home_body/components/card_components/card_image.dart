import 'package:flutter/material.dart';

class RestaurantCardImage extends StatelessWidget {
  const RestaurantCardImage({Key? key, required this.fileName})
      : super(key: key);
  final String fileName;

  @override
  Widget build(BuildContext context) {
    ImageProvider image = const AssetImage('assets/images/placeholder.png');

    if (fileName.isNotEmpty) {
      image = NetworkImage(fileName);
    }
//     fitWidth → const BoxFit
// Make sure the full width of the source is shown, regardless of whether this means the source overflows the target box vertically.

// To actually clip the content, use clipBehavior: Clip.hardEdge alongside this in a FittedBox.
//fit: BoxFit.fitWidth)
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)),
        color: Colors.transparent,
        image: DecorationImage(fit: BoxFit.cover, image: image),
      ),
      height: 100.0,
      width: 225.0,
    );
    // SizedBox(
    //     height: 100,
    //     width: 225,
    //     child: FittedBox(
    //         fit: BoxFit.fitWidth,
    //         clipBehavior: Clip.hardEdge,
    //         child: ClipRRect(
    //           borderRadius: const BorderRadius.only(
    //               bottomLeft: Radius.circular(15.0),
    //               bottomRight: Radius.circular(15.0)),
    //           child: Image(image: image, BoxFit),
    //         )));
  }
}
