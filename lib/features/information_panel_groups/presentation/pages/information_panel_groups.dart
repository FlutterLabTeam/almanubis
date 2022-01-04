import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:almanubis/core/components/carousel_image_user/carousel_image_user.dart';
import 'package:almanubis/core/components/custom_switch/custom_switch.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:flutter/material.dart';

enum InformationPanelGroupsEnum { admin, user }

class InformationPanelGroups extends StatefulWidget {
  final InformationPanelGroupsEnum typeUser;

  const InformationPanelGroups({Key? key, required this.typeUser})
      : super(key: key);

  @override
  _InformationPanelGroupsState createState() => _InformationPanelGroupsState();
}

class _InformationPanelGroupsState extends State<InformationPanelGroups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CompanyColor.color().primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(
                  left: 36, right: 36, bottom: 26, top: 100),
              child: Text(
                "Descripción",
                style: CompanyFontStyle.style().titleStyleLight,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit, eros quis tempor tempor, odio tellus venenatis turpis, a semper orci enim in nibh. Duis dictum ipsum non dolor aliquam, at euismod massa volutpat...",
                style: CompanyFontStyle.style().textCartWhiteStyle,
              ),
            ),
          ),

          viewWidget(
            enumData: widget.typeUser,
            body: Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                child: Text(
                  "Participantes",
                  style: CompanyFontStyle.style().titleStyleLight,
                ),
              ),
            ),
          ),viewWidget(
            enumData: widget.typeUser,
            body: Expanded(
              flex: 0,
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: CarouselImageUser(
                  model: CarouselImageUserModel(
                    handledIcon: () {},
                    listUserData: [
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                      UserModel(
                        name: "Jeison Vargas",
                        image:
                        "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
              child: Text(
                "Notificaciones",
                style: CompanyFontStyle.style().titleStyleLight,
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: CustomSwitch(
                label: "Silenciar notificaciones",
                state: true,
                handledSwitch: (bool state) {},
              )),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        model: CustomFloatingButtonModel(
          handledIcon: () {},
          icon: Icons.add,
        ),
      ),
    );
  }

  Widget viewWidget({required Widget body, required InformationPanelGroupsEnum enumData}){
    if(enumData == InformationPanelGroupsEnum.admin) return body;
    return Container();
  }
}
