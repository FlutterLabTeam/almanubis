import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/input/custom_input.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/components/body/custom_body.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static late Size size;
  static late TextEditingController emailController;
  static late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomBody(
      model: CustomBodyModel(
        color: ColorCustomBody.dark,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.17,
                  margin: EdgeInsets.only(top: size.height * 0.13),
                  width: double.infinity,
                  child: CustomImage(
                    model: CustomImageModel(color: CustomImageColor.light),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.04),
                  child: Text(
                    "almanubis",
                    style: CompanyFontStyle.style().titleAppLight,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.1,
                    bottom: size.height * 0.02,
                    right: size.width * 0.12,
                    left: size.width * 0.12,
                  ),
                  child: CustomInput(
                    model: CustomInputColorModel(
                        label: "Usuario", controller: emailController),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.12),
                  child: CustomInput(
                    model: CustomInputColorModel(
                      label: "Contraseña",
                      controller: passwordController,
                      typeInput: CustomInputType.password,
                      isObscure: true,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.085,
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.12,
                      vertical: size.height * 0.08),
                  child: CustomButton(
                    model: CustomButtonModel(
                      label: "Entrar",
                      handledButton: () => Navigator.of(context).pushNamed('/adminPanel'),
                      color: CustomButtonColor.dark,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Solicita el acceso a ",
                      style: TextStyle(
                          color: CompanyColor.color().third, fontSize: 12),
                    ),
                    GestureDetector(
                      child: Text(
                        "Info@almanubis.com",
                        style: TextStyle(
                            color: CompanyColor.color().second, fontSize: 12),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    ));
  }
}
