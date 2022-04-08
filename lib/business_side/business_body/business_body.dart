import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/business_side/business_body/components/business_closeopen.dart';
import 'package:out_app/business_side/business_body/components/business_top_section.dart';
import 'package:out_app/shared/shared_components/button.dart';
import 'package:out_app/user_side/home_body/components/divider.dart';

class BusinessBody extends StatelessWidget {
  const BusinessBody({
    Key? key,
    required this.restaurantID,
  }) : super(key: key);
  final String restaurantID;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BusTopSection(restaurantID: restaurantID),
        const DividerPadding(),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: BusinessCloseOpen(restaurantID: restaurantID),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () async {
              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                      title: const Center(
                          child: Text(
                        'Log Out',
                      )),
                      content: const Text(
                        'Are you sure you want to log out?',
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                  color: (Theme.of(context).colorScheme.error)),
                            ))
                      ],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))));
                },
              );
            },
            child: const Text('Log out'),
            style: getOutButtonStyle(Theme.of(context).colorScheme.error).merge(
                ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(180, 50)))),
          ),
        )
      ],
    );
  }
}
