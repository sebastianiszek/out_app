import 'package:flutter/material.dart';
import 'package:out_app/out_app_icons.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';

class DisabledBookingButton extends StatelessWidget {
  const DisabledBookingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = ThemeData.light().disabledColor;
    Color buttonTextColor = Colors.black54;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: ElevatedButton.icon(
        onPressed: () async {
          outSnackbar('Restaurant is closed', context);
        },
        style: getOutButtonStyle(buttonColor).merge(ButtonStyle(
            textStyle:
                MaterialStateProperty.all(TextStyle(color: buttonTextColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(40, 18, 40, 18)))),
        icon: Icon(
          OutApp.logo,
          color: buttonTextColor,
        ),
        label: Text(
          "Closed Restaurant",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.merge(TextStyle(color: buttonTextColor)),
        ),
      ),
    );
  }
}
