import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/components/noData/no_data.dart';
import 'package:almanubis/core/components/header_chat/header_chat.dart';
import 'package:almanubis/core/components/custom_chat/custom_chat.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/chat_input.dart';
import 'package:almanubis/features/chat_group/presentation/bloc/chat_group_bloc.dart';
import 'package:almanubis/features/information_panel_groups/presentation/pages/information_panel_groups.dart';

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
  late bool isStream = false;
  late bool isSubmitHandled = true;
  late Stream<QuerySnapshot> dataStream;
  late TextEditingController controller = TextEditingController();
  late List<ChatModel> listChats = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatGroupBloc>(context)
        .add(GetChatStreamEvent(idGroup: widget.model.groupModel!.id!));
  }

  @override
  void dispose() {
    super.dispose();
    isStream = false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          //GetChatGroupStreamState
          body: BlocBuilder<ChatGroupBloc, ChatGroupState>(
        builder: (context, state) {
          if (state is GetChatGroupStreamState) {
            dataStream = state.stream;
            isStream = true;
          }
          if (state is CreateChatState) {
            isSubmitHandled = true;
            controller.text = "";
            BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
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
                fit: FlexFit.tight,
                flex: 1,
                child: isStream
                    ? StreamBuilder(
                        stream: dataStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapShot) {
                          if (snapShot.hasData) {
                            handledMapData(snapShot.data!);
                          }
                          return listChats.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: listChats.length,
                                  reverse: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ChatModel chat = listChats[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                      ),
                                      child: CustomChat(
                                        model: CustomChatModel(
                                          color: chat.idUserCreate ==
                                                  widget.model.userModel!.uid!
                                              ? CustomChatColor.light
                                              : CustomChatColor.dark,
                                          chatModel: chat,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: size.height * 0.12,
                                  ),
                                  child: const NoData(),
                                );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              ChatInput(
                isSend: isSend,
                controller: controller,
                handledSubmitChat: () => handledSaveMessage(),
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
          );
        },
      )),
    );
  }

  handledMapData(QuerySnapshot data) {
    listChats = data.docs.map((e) => ChatModel.fromJson(e.data(), e.id)).toList();
    listChats.sort((a,b) => b.dateCreate.compareTo(a.dateCreate));
  }

  handledSaveMessage() {
    if (controller.text.isNotEmpty && isSubmitHandled) {
      isSubmitHandled = false;
      List<String> listUser = [];
      listUser = widget.model.groupModel!.listUser.map((e) => e.uid!).toList();

      BlocProvider.of<ChatGroupBloc>(context).add(
        CreateChatEvent(
          chatModel: ChatModel(
              label: controller.text,
              idGroup: widget.model.groupModel!.id!,
              dateCreate: DateTime.now(),
              nameUser: widget.model.userModel!.name,
              idUserCreate: widget.model.userModel!.uid!,
              imageUser: widget.model.userModel!.image!,
              listUserReceiver: listUser,
              listUserViewed: []),
        ),
      );
    }
  }
}
