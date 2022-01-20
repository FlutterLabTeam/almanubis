import 'package:almanubis/features/information_panel_groups/presentation/bloc/information_panel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/components/custom_switch/custom_switch.dart';
import 'package:almanubis/core/components/carousel_image_user/carousel_image_user.dart';
import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InformationPanelGroupsEnum { admin, user }

class InformationPanelGroupsModel {
  final InformationPanelGroupsEnum? typeUser;
  final GroupModel? groupModel;
  final UserModel? userModel;

  InformationPanelGroupsModel({
    this.userModel,
    this.groupModel,
    this.typeUser = InformationPanelGroupsEnum.user,
  });
}

class InformationPanelGroups extends StatefulWidget {
  final InformationPanelGroupsModel model;

  const InformationPanelGroups({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _InformationPanelGroupsState createState() => _InformationPanelGroupsState();
}

class _InformationPanelGroupsState extends State<InformationPanelGroups> {
  bool statusNotification = false;

  @override
  void initState() {
    super.initState();
    String id = widget.model.groupModel!.listUserNotify.firstWhere(
        (element) => element == widget.model.userModel!.uid,
        orElse: () => '');
    statusNotification = id.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformationPanelBloc, InformationPanelState>(
        builder: (context, state) {
      if (state is ActiveNotificationState) {
        statusNotification = true;
      }
      if (state is DisableNotificationErrorState) {
        statusNotification = true;
      }
      if (state is DisableNotificationState) {
        statusNotification = false;
      }
      if (state is ActiveNotificationErrorState) {
        statusNotification = false;
      }
      if (state is DeleteUserState) {
        widget.model.groupModel!.listUser.removeWhere((element) => element == state.userModel);
      }

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
                margin:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                child: Text(
                  widget.model.groupModel!.description,
                  style: CompanyFontStyle.style().textCartWhiteStyle,
                ),
              ),
            ),
            viewWidget(
              enumData: widget.model.typeUser!,
              body: Expanded(
                flex: 0,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                  child: Text(
                    "Participantes",
                    style: CompanyFontStyle.style().titleStyleLight,
                  ),
                ),
              ),
            ),
            viewWidget(
              enumData: widget.model.typeUser!,
              body: Expanded(
                flex: 0,
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: CarouselImageUser(
                    model: CarouselImageUserModel(
                      handledIcon: (e) => handledDeleteUser(e),
                      listUserData: widget.model.groupModel!.listUser,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
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
                  state: statusNotification,
                  handledSwitch: (bool state) =>
                      handledChangeStateNotification(state),
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
    });
  }

  Widget viewWidget({
    required Widget body,
    required InformationPanelGroupsEnum enumData,
  }) {
    if (enumData == InformationPanelGroupsEnum.admin) return body;
    return Container();
  }

  handledChangeStateNotification(bool state) {
    statusNotification = state;
    if (state) {
      BlocProvider.of<InformationPanelBloc>(context).add(
        ActiveNotificationEvent(
          idUser: widget.model.userModel!.uid!,
          idGroup: widget.model.groupModel!.id!,
        ),
      );
    } else {
      BlocProvider.of<InformationPanelBloc>(context).add(
        DisableNotificationEvent(
          idUser: widget.model.userModel!.uid!,
          idGroup: widget.model.groupModel!.id!,
        ),
      );
    }
  }

  handledDeleteUser(UserModel user){
    BlocProvider.of<InformationPanelBloc>(context).add(
      DeleteUserEvent(
        user: user,
        idGroup: widget.model.groupModel!.id!,
      ),
    );
  }
}
