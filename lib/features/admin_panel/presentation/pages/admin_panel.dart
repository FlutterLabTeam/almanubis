import 'package:flutter/material.dart';
import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/features/admin_panel/presentation/widgets/body_admin.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  static late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: BodyAdmin(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.1,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: CustomButton(
                  model: CustomButtonModel(
                      handledButton: () =>
                          Navigator.of(context).pushNamed('/listChat'),
                      color: CustomButtonColor.dark,
                      label: "CREAR GRUPO"),
                ),
              ),
              const SizedBox(height: 70),
              Container(
                height: size.height * 0.1,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: CustomButton(
                  model: CustomButtonModel(
                      handledButton: () =>
                          Navigator.of(context).pushNamed('/newUser'),
                      color: CustomButtonColor.light,
                      label: "CREAT USUARIO"),
                ),
              )
            ]),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onTapPlus: () {},
        onTapPerson: () => Navigator.of(context).pushNamed('/userConfiguration'),
        model: CustomNavigationBarModel(
          color: CustomNavigationBarColors.black,
        ),
      ),
    );
  }
}
