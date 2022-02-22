import 'package:flutter/material.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/util/firebaseNotificationHandler.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/cart_chat_home/card_chat_home.dart';
import 'package:almanubis/features/chat_group/presentation/pages/chat_group.dart';
import 'package:almanubis/features/list_chat/presentation/bloc/list_chat_bloc.dart';

class ListChat extends StatefulWidget {
  final UserModel userModel;

  const ListChat({Key? key, required this.userModel}) : super(key: key);

  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  static late Size size;
  static late bool isStreamNotEmpty = false;
  static late Stream<QuerySnapshot> streamData;
  static late List<GroupModel> listChat = [];
  static late List<ChatModel> listMessageChat = [];
  FirebaseNotifications firebaseNotifications = FirebaseNotifications();

  @override
  void initState() {
    firebaseNotifications.setUpFirebase(context: context, userModel: widget.userModel);
    BlocProvider.of<ListChatBloc>(context).add(GetAllListChatEvent(userId: widget.userModel.uid!));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    isStreamNotEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.now();
    return BlocBuilder<ListChatBloc, ListChatState>(builder: (context, state) {
      if (state is GetAllListChatStreamState) {
        isStreamNotEmpty = true;
        streamData = state.stream;
      }
      if (state is GetAllListChatState) {
        listMessageChat = state.listChatModel;
        BlocProvider.of<ListChatBloc>(context).add(
          GetAllListChatStreamEvent(
            userId: widget.userModel.uid!,
            isAdmin: widget.userModel.rol == "ADMIN",
          ),
        );
      }
      return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                model: CustomAppBarModel(
                  disableGoBack: true,
                  height: size.height * 0.18,
                  elevation: ElevationCount.E12,
                  body: SizedBox(
                    height: size.height * 0.12,
                    width: double.infinity,
                    child: CustomImage(
                      model: CustomImageModel(color: CustomImageColor.dark),
                    ),
                  ),
                  handledGoBack: () {},
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: isStreamNotEmpty
                      ? StreamBuilder(
                          stream: streamData,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                            if (snapShot.hasData) {
                              listChat = snapShot.data!.docs
                                  .map((e) => GroupModel.fromJson(e.data(), e.id))
                                  .toList();
                            }
                            return ListView.builder(
                              itemCount: listChat.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                GroupModel group = listChat[index];
                                int counter = handledCalculateMessage(group);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: CardChatHome(
                                    model: CardChatHomeModel(
                                        title: group.title,
                                        dateTime: dateTime,
                                        description: group.description,
                                        counter: counter,
                                        imageUrl: group.image.isEmpty
                                            ? noImage
                                            : group.image,
                                        handledCart: () =>
                                            handledPushChat(group)),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              )
            ],
          ),
          bottomNavigationBar: CustomNavigationBar(
            model: CustomNavigationBarModel(),
            onTapMessage: () {},
            onTapPerson: () => Navigator.of(context).pushReplacementNamed(
                '/userConfiguration',
                arguments: widget.userModel),
          ),
        ),
      );
    });
  }

  handledPushChat(GroupModel groupModel) => Navigator.of(context).pushNamed(
        '/chatGroup',
        arguments: ChatGroupModel(
          groupModel: groupModel,
          userModel: widget.userModel,
        ),
      );

  int handledCalculateMessage(GroupModel groupModel) {
    List<ChatModel> chatModel = listMessageChat
        .where((element) => element.idGroup == groupModel.id!)
        .toList();
    int data = chatModel
        .where((element) =>
            element.listUserReceiver.contains(widget.userModel.uid!))
        .toList()
        .length;
    return data;
  }
}
