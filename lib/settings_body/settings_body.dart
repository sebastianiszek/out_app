import 'package:flutter/material.dart';
import 'package:out_app/home_body/components/divider.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Icon(Icons.account_circle, size: 80))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.merge(const TextStyle(color: Color(0xFF000000))),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text("example@email.com",
                    style: Theme.of(context).textTheme.bodyText1))
          ],
        ),
        const DividerPadding(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: TextButton(
              onPressed: () {},
              child: Row(children: const [
                Icon(Icons.chevron_left),
                Text('Update Account Details')
              ])),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: TextButton(
              onPressed: () {},
              child: Row(
                  children: const [Icon(Icons.chevron_left), Text('Policy')])),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: TextButton(
              onPressed: () {},
              child: Row(
                  children: const [Icon(Icons.chevron_left), Text('Help')])),
        ),
        const DividerPadding(),
        TextButton(
          style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.error),
          onPressed: () {},
          child: Row(
            children: const [
              Icon(
                Icons.chevron_left,
              ),
              Text(
                'Logout',
              )
            ],
          ),
        )
      ],
    );
  }
}
