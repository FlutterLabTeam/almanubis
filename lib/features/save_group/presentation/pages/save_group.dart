import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:almanubis/features/user_configuration/presentation/widgets/image_user.dart';
import 'package:almanubis/core/components/image_user_option/image_user_option.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';

class SaveGroup extends StatefulWidget {
  const SaveGroup({Key? key}) : super(key: key);

  @override
  State<SaveGroup> createState() => SaveGroupState();
}

class SaveGroupState extends State<SaveGroup> {
  static late Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              model: CustomAppBarModel(
                body: Text(
                  "",
                  style: CompanyFontStyle.style().titleStyleDark,
                ),
                handledGoBack: () => Navigator.of(context).pop(),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const ImageUser(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "NOMBRE DE GRUPO",
                          style: CompanyFontStyle.style().titleStyleDark,
                        ),
                      ),
                      Text(
                        "Descripción del grupo",
                        style: CompanyFontStyle.style().textStyle,
                      ),
                    ],
                  )),
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                color: CompanyColor.color().primary,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Text(
                          "Participantes",
                          style: CompanyFontStyle.style().titleStyleLight,
                        ),
                      ),
                      GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 4,
                        children: List.generate(
                            40,
                            (index) =>  ImageUserOption(
                              model: ImageUserOptionModel(
                                handledIcon: (){},
                                icon: Icons.people,
                                image: "https://laboratoriosniam.com/wp-content/uploads/2018/07/michael-dam-258165-unsplash_WEB2.jpg",
                              )
                            ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          onTapPlus: () {},
          model: CustomNavigationBarModel(),
          onTapMessage: () => Navigator.of(context).pushNamed('/listChat'),
          onTapPerson: () =>
              Navigator.of(context).pushNamed('/userConfiguration'),
        ),
        floatingActionButton: CustomFloatingButton(
          model: CustomFloatingButtonModel(
            icon: Icons.arrow_forward,
            handledIcon: () {},
          ),
        ),
      ),
    );
  }
}
