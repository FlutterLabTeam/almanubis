import 'package:flutter/cupertino.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/util/date_format.dart';
import 'package:almanubis/core/components/cart_chat/cart_chat.dart';
import 'package:almanubis/core/components/square_image/square_image.dart';
import 'package:flutter/material.dart';

enum CustomChatColor {
  light,
  dark,
}

class CustomChatModel {
  final CustomChatColor? color;
  final ChatModel chatModel;

  CustomChatModel({
    this.color = CustomChatColor.dark,
    required this.chatModel,
  });
}

class CustomChat extends StatelessWidget {
  static late Size size;
  final CustomChatModel model;

  const CustomChat({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: model.color == CustomChatColor.light ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            model.color == CustomChatColor.dark
                ? Expanded(
              flex: 0,
              child: SquareImage(
                model: SquareImageModel(
                  urlImage: model.chatModel.imageUser,
                  size: size.width * 0.12,
                ),
              ),
            )
                : Expanded(
              flex: 0,
              child: Text(dateFormatHour(model.chatModel.dateCreate)),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: CartChat(
                  size: size,
                  model: CartChatModel(
                      color: handledGenerateColor(model.color!),
                      textChat: model.chatModel.label),
                ),
              ),
            ),
            model.color == CustomChatColor.dark
                ? Expanded(
              flex: 0,
              child: Text(dateFormatHour(model.chatModel.dateCreate)),
            )
                : Container(),
          ],
        ),
        model.chatModel.pathImage.isNotEmpty ? Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
            vertical: size.height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(model.chatModel.pathImage)
            )
          ),
          height: size.height * 0.3,
          width: size.width * 0.4,
        ) : Container()
      ],
    );
  }

  CartChatColor handledGenerateColor(CustomChatColor customChatColor) {
    switch (customChatColor) {
      case CustomChatColor.light:
        return CartChatColor.light;
      case CustomChatColor.dark:
        return CartChatColor.dark;
    }
  }
}
