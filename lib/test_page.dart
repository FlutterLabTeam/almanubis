import 'package:flutter/material.dart';

import 'core/components/navigation/navigation_bar.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 69,
          child: CustomNavigationBar(
            onTapMessage: () => Navigator.of(context).pushReplacementNamed('/listChat'),
            onTapPerson: () => Navigator.of(context).pushReplacementNamed('/userConfiguration'),
            model: CustomNavigationBarModel(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 69,
          child: CustomNavigationBar(
              model: CustomNavigationBarModel(),
              onTapPerson: () => Navigator.of(context).pushReplacementNamed('/userConfiguration'),
              onTapMessage: () => Navigator.of(context).pushReplacementNamed('/listChat'),
              onTapPlus: () {}),
        ),
      ]),
    );
  }
}
