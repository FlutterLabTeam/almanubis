import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/components/body/custom_body.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/features/user_configuration/presentation/widgets/image_user.dart';

class UserConfiguration extends StatefulWidget {
  const UserConfiguration({Key? key}) : super(key: key);

  @override
  _UserConfigurationState createState() => _UserConfigurationState();
}

class _UserConfigurationState extends State<UserConfiguration> {
  static late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomBody(
        model: CustomBodyModel(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                ),
                ImageUser(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.07),
                  child: Text(
                    "NOMBRE DE USUARIO",
                    style: CompanyFontStyle.style().titleStyleDark,
                  ),
                ),
                Text(
                  "Descripcion",
                  style: CompanyFontStyle.style().subTitleStyle,
                )
              ],
            ),
            color: ColorCustomBody.light),
      ),
      bottomNavigationBar: CustomNavigationBar(
        model: CustomNavigationBarModel(
          color: CustomNavigationBarColors.black,
        ),
      ),
    );
  }
}