import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/user_side/home_body/components/divider.dart';
import 'package:out_app/user_side/settings_body/screens/help_screen.dart';
import 'package:out_app/user_side/settings_body/screens/policy_screen.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    String userEmail = 'example@mail.com';

    if (currentUser != null) {
      userEmail = currentUser.email!;
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Icon(Icons.account_circle, size: 70))
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "User",
        //       style: Theme.of(context)
        //           .textTheme
        //           .headline5
        //           ?.merge(const TextStyle(color: Color(0xFF000000))),
        //     )
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(userEmail,
                    style: Theme.of(context).textTheme.bodyText1))
          ],
        ),
        const DividerPadding(),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        //   child: TextButton(
        //       onPressed: () {

        //         FirebaseAuth.instance.currentUser.
        //       },
        //       child: Row(children: const [
        //         Icon(Icons.chevron_left),
        //         Text('Update Account Details')
        //       ])),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PolicyScreen(),
                  ),
                );
              },
              child: Row(
                  children: const [Icon(Icons.chevron_left), Text('Policy')])),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpScreen(),
                  ),
                );
              },
              child: Row(
                  children: const [Icon(Icons.chevron_left), Text('Help')])),
        ),
        const DividerPadding(),
        TextButton(
          style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.error),
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
          child: Row(
            children: const [
              Icon(
                Icons.chevron_left,
              ),
              Text(
                'Log out',
              )
            ],
          ),
        )
      ],
    );
  }
}
