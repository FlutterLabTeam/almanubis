import 'package:almanubis/features/chat_group/presentation/pages/chat_group.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/cart_chat_home/card_chat_home.dart';
import 'package:almanubis/features/list_chat/presentation/bloc/list_chat_bloc.dart';

class ListChat extends StatefulWidget {
  final UserModel userModel;

  const ListChat({Key? key, required this.userModel}) : super(key: key);

  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  static late Size size;
  static late List<GroupModel> listChat = [];

  @override
  void initState() {
    BlocProvider.of<ListChatBloc>(context).add(GetAllListChat());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.now();
    return BlocBuilder<ListChatBloc, ListChatState>(builder: (context, state) {
      if (state is GetAllListChatState) {
        listChat = state.listChatModel;
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
              SizedBox(
                height: size.height * 0.7115,
                child: ListView.builder(
                  itemCount: listChat.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    GroupModel chat = listChat[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CardChatHome(
                        model: CardChatHomeModel(
                          title: chat.title,
                          dateTime: dateTime,
                          description: chat.description,
                          counter: 3,
                          imageUrl: chat.image.isEmpty ? noImage : chat.image,
                          handledCart: () => handledPushChat(chat)
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          bottomNavigationBar: CustomNavigationBar(
            model: CustomNavigationBarModel(),
            onTapMessage: () {},
            onTapPerson: () => Navigator.of(context)
                .pushNamed('/userConfiguration', arguments: widget.userModel),
          ),
        ),
      );
    });
  }

  handledPushChat(GroupModel groupModel) =>
    Navigator.of(context).pushNamed(
      '/chatGroup',
      arguments: ChatGroupModel(
        groupModel: groupModel,
        userModel: widget.userModel,
      ),
    );
}
