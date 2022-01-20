import 'package:almanubis/features/information_panel_groups/presentation/pages/information_panel_groups.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/components/header_chat/header_chat.dart';
import 'package:almanubis/core/components/custom_chat/custom_chat.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/chat_input.dart';

class ChatGroupModel {
  final UserModel? userModel;
  final GroupModel? groupModel;

  ChatGroupModel({
    this.userModel,
    this.groupModel,
  });
}

class ChatGroup extends StatefulWidget {
  final ChatGroupModel model;

  const ChatGroup({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _ChatGroupState createState() => _ChatGroupState();
}

class _ChatGroupState extends State<ChatGroup> {
  late Size size;
  late bool isSend = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HeaderChat(
              model: HeaderChatModel(
                image: widget.model.groupModel!.image,
                title: widget.model.groupModel!.title,
                description: widget.model.groupModel!.description,
                handledMenu: () => Navigator.pushNamed(
                  context,
                  '/informationPanelGroups',
                  arguments: InformationPanelGroupsModel(
                    userModel: widget.model.userModel,
                    groupModel: widget.model.groupModel,
                    typeUser: widget.model.userModel!.rol == "USER"
                        ? InformationPanelGroupsEnum.user
                        : InformationPanelGroupsEnum.admin,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: CustomChat(
                        model: CustomChatModel(
                          color: CustomChatColor.dark,
                          userModel: UserModel(
                              image:
                                  "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                              name: "Jeison",
                              email: "",
                              dateCreate: DateTime.now(),
                              query: [],
                              rol: ""),
                          chatModel: ChatModel(
                            label:
                                "Hola mundo Como estan todos,  estan todos mundo Como Hola  ",
                            dateCreate: DateTime.now(),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            ChatInput(
              isSend: isSend,
              controller: controller,
              handledChangeInput: (String text) {
                if (text.isNotEmpty) {
                  setState(() {
                    isSend = true;
                  });
                } else {
                  setState(() {
                    isSend = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
