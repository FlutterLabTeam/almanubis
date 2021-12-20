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
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 69,
          child: CustomNavigationBar(
            model: CustomNavigationBarModel(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 69,
          child: CustomNavigationBar(
              model: CustomNavigationBarModel(),
              onTapPlus: () {
                print('tap plus');
              }),
        ),
      ]),
    );
  }
}
