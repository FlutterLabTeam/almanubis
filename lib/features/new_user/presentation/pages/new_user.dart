import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/input/custom_input.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  static late Size size;
  static late TextEditingController userController;
  static late TextEditingController emailController;
  static late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              model: CustomAppBarModel(
                body: Text(
                  "NUEVO USUARIO",
                  style: CompanyFontStyle.style().titleStyle,
                ),
                handledGoBack: () {},
              ),
            ),
            Container(
              height: size.height * 0.17,
              margin: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
              ),
              width: double.infinity,
              child: CustomImage(
                model: CustomImageModel(color: CustomImageColor.dark),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
                right: size.width * 0.12,
                left: size.width * 0.12,
              ),
              child: CustomInput(
                model: CustomInputColorModel(
                    color: CustomInputColor.dark,
                    label: "Usuario",
                    controller: userController),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
                right: size.width * 0.12,
                left: size.width * 0.12,
              ),
              child: CustomInput(
                model: CustomInputColorModel(
                    color: CustomInputColor.dark,
                    label: "Correo electronico",
                    controller: emailController),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
                right: size.width * 0.12,
                left: size.width * 0.12,
              ),
              child: CustomInput(
                model: CustomInputColorModel(
                    color: CustomInputColor.dark,
                    label: "Contraseña",
                    controller: passwordController),
              ),
            ),
            Container(
              height: size.height * 0.085,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.12,
                  vertical: size.height * 0.02),
              child: CustomButton(
                model: CustomButtonModel(
                  label: "CREAR USUARIO",
                  handledButton: () => Navigator.of(context).pushNamed('/adminPanel'),
                  color: CustomButtonColor.dark,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onTapPlus: () {},
        model: CustomNavigationBarModel(),
      ),
    );
  }
}
