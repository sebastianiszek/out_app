import 'package:flutter/material.dart';

class RestaurantViewImage extends StatelessWidget {
  const RestaurantViewImage({Key? key, required this.restaurantTitle})
      : super(key: key);
  final String restaurantTitle;

  @override
  Widget build(BuildContext context) {
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
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.black45,
                Colors.black.withAlpha(0),
              ],
            ),
          ),
          height: 190.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 5, 4, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(color: Color(0xFFFFFFFF)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 182),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFBFF),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    restaurantTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
