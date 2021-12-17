import 'package:almanubis/core/components/start/paint_start.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/input/custom_input.dart';
import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 150,
            child: CustomInput(
              model: CustomInputColorModel(
                label: "Usuario",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 150,
            child: CustomInput(
              model: CustomInputColorModel(
                label: "Password",
                color: CustomInputColor.dark,
                typeInput: CustomInputType.password,
                isObscure: false,
              ),
            ),
          ),SizedBox(
            height: 20,
          ),
          Container(
            width: 20,
            height: 20,
            child: PaintStart(
            )
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
