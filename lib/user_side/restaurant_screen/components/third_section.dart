import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantViewThirdSection extends StatelessWidget {
  const RestaurantViewThirdSection(
      {Key? key,
      required this.description,
      required this.openingTime,
      required this.url})
      : super(key: key);
  final String description;
  final String openingTime;
  final String url;

  @override
  Widget build(BuildContext context) {
    String newOpeningTime = openingTime.replaceAll('\\n', '\n');
    bool isUrl = url.isEmpty;

    return Column(
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 7, 15, 30),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          "Opening Times",
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 7, 15, 30),
          child: Text(
            newOpeningTime,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        isUrl
            ? Container()
            : Column(
                children: [
                  Text(
                    "Menu",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                    child: ElevatedButton(
                      style: getOutButtonStyle(
                              Theme.of(context).colorScheme.primary)
                          .merge(ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(50, 15, 50, 15)))),
                      onPressed: () async {
                        try {
                          _launchURL(url);
                        } catch (e) {
                          outSnackbar('Could not open menu', context);
                        }
                      },
                      child: const Text('View'),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
