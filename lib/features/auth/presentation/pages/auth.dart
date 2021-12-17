import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
        SizedBox(
          height: 20,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 69,
            child: CustomButton(
              handledButton: () {},
              label: "CREAR USUARIO",
              model: CustomButtonModel(color: CustomButtonColor.dark),
            )),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 150,
            child: CustomImage(
              model: CustomImageModel(color: CustomImageColor.dark),
            )),
      ]),
    );
  }
}
