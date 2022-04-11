import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String exampleText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    const String exampleText2 =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

    return Scaffold(
        backgroundColor: const Color(0xFFFFFBFF),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Row(
              children: [
                const BackButton(),
                Text(
                  'Policy',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text('Example Question?',
                    style: Theme.of(context).textTheme.headline6)),
            const Text(exampleText),
            Column(
              children: const [
                BulletPointText(text: exampleText2),
                BulletPointText(text: exampleText2),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text('Example Question?',
                    style: Theme.of(context).textTheme.headline6)),
            const Text(exampleText),
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text('Example Question?',
                    style: Theme.of(context).textTheme.headline6)),
            const Text(exampleText),
            Column(
              children: const [
                BulletPointText(text: exampleText2),
                BulletPointText(text: exampleText2),
              ],
            ),
          ],
        ));
  }
}

class BulletPointText extends StatelessWidget {
  const BulletPointText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Text('• ' + text),
    );
  }
}
