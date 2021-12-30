import 'package:almanubis/core/components/custom_chat/custom_chat.dart';
import 'package:almanubis/core/components/header_chat/header_chat.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:flutter/material.dart';

class ChatGroup extends StatefulWidget {
  const ChatGroup({
    Key? key,
  }) : super(key: key);

  @override
  _ChatGroupState createState() => _ChatGroupState();
}

class _ChatGroupState extends State<ChatGroup> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HeaderChat(
              model: HeaderChatModel(
                  image:
                      "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                  description:
                      "Juan, Raúl, Fernando, Pol, Marta Juan, Raúl, Fernando, Pol, Marta",
                  title: "Reiki Usui",
                  handledMenu: () {}),
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
                          color: CustomChatColor.light,
                          userModel: UserModel(
                              image:
                                  "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                              name: "Jeison"),
                          chatModel: ChatModel(
                            label: "Hola mundo Como estan todos,  estan todos mundo Como Hola  ",
                            dateCreate: DateTime.now(),
                          ),
                        ),
                      ),
                    );
                  }),
            ),



            Container(
              width: size.width,
              height: size.height*0.1,
              color: Colors.purple,
              child: Row(
                children: [
                  Expanded(child: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.link),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
