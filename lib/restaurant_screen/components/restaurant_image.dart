import 'package:flutter/material.dart';
import 'package:out_app/restaurant_screen/components/save_button.dart';

class RestaurantViewImage extends StatelessWidget {
  const RestaurantViewImage(
      {Key? key,
      required this.restaurantTitle,
      required this.restaurantID,
      required this.type})
      : super(key: key);
  final String restaurantTitle;
  final String restaurantID;
  final String type;

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
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 32,
              ),
              OutSaveButtonLoad(
                name: restaurantTitle,
                restaurantID: restaurantID,
                type: type,
              )
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
