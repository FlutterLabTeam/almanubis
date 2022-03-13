import 'package:flutter/material.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/cart_chat_home/card_chat_home.dart';
import 'package:almanubis/features/chat_group/presentation/pages/chat_group.dart';
import 'package:almanubis/features/list_chat/presentation/bloc/list_chat_bloc.dart';
import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';

class ListChat extends StatefulWidget {
  final UserModel userModel;

  const ListChat({Key? key, required this.userModel}) : super(key: key);

  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  static late Size size;
  static late bool isListenChange;
  static late bool isGetData = false;
  static late bool isStreamNotEmpty = false;
  static late List<GroupModel> listChatGroup = [];
  static late Stream<QuerySnapshot> streamData;
  static late List<ChatModel> listMessageChat = [];

  @override
  void initState() {
    super.initState();
    isGetData = true;
    isListenChange = false;
    BlocProvider.of<ListChatBloc>(context).add(GetAllListChatEvent(userId: widget.userModel.uid!));
  }

  @override
  void dispose() {
    super.dispose();
    isStreamNotEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocBuilder<ListChatBloc, ListChatState>(
      builder: (context, state) {
        if (state is GetAllListChatStreamState) {
          isStreamNotEmpty = true;
          streamData = state.stream;
        }
        if (state is GetAllListChatState) {
          listMessageChat = state.listChatModel;
          BlocProvider.of<ListChatBloc>(context).add(
            GetAllListGroupStreamEvent(
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
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                              handledSnapShotFunction(snapShot);
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.05,
                                    horizontal: 25),
                                itemCount: listChatGroup.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  GroupModel group = listChatGroup[index];
                                  int counter = handledCalculateMessage(group);
                                  return CardChatHome(
                                    model: CardChatHomeModel(
                                      counter: counter,
                                      title: group.title,
                                      description: group.description,
                                      handledCart: () => handledPushChat(group),
                                      dateTime:
                                          group.dateUpdate ?? group.dateCreate,
                                      imageUrl: group.image.isEmpty
                                          ? noImage
                                          : group.image,
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : const Center(
                            child: CustomCircularProgressIndicator(),
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  handledPushChat(GroupModel groupModel) {
    isGetData = false;
    listMessageChat.removeWhere((element) => element.idGroup == groupModel.id);
    BlocProvider.of<ListChatBloc>(context).add(ListChatInitialEvent());
    Navigator.of(context).pushNamed(
      '/chatGroup',
      arguments: ChatGroupModel(
        groupModel: groupModel,
        userModel: widget.userModel,
      ),
    );
  }

  int handledCalculateMessage(GroupModel groupModel) => listMessageChat
      .where((element) => element.idGroup == groupModel.id!)
      .toList()
      .length;

  handledListenChange(List<DocumentChange> dataChange) {
    List<GroupModel> listChatGroupChange = dataChange
        .map((e) => GroupModel.fromJson(e.doc.data(), e.doc.id))
        .toList();
    for (var element in listChatGroupChange) {
      ChatModel chatModel = ChatModel.fromJsonNoData(
          idGroup: element.id, listUserReceiver: [widget.userModel.uid!]);
      listMessageChat.add(chatModel);
    }
  }

  handledSnapShotFunction(AsyncSnapshot<QuerySnapshot> snapShot) {
    if(isGetData){
      if (snapShot.hasData) {
        listChatGroup = snapShot.data!.docs
            .map((e) => GroupModel.fromJson(e.data(), e.id))
            .toList();
        if (isListenChange) {
          handledListenChange(snapShot.data!.docChanges);
        }
        isListenChange = true;
      }
    }else{
      isGetData = true;
    }

  }
}
