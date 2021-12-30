import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:almanubis/core/components/cart_chat/cart_chat.dart';
import 'package:almanubis/core/components/square_image/square_image.dart';

enum CustomChatColor {
  light,
  dark,
}

class CustomChatModel {
  final CustomChatColor? color;
  final ChatModel chatModel;
  final UserModel userModel;

  CustomChatModel({
    this.color = CustomChatColor.dark,
    required this.chatModel,
    required this.userModel,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        model.color == CustomChatColor.dark
            ? Expanded(
                flex: 0,
                child: SquareImage(
                  model: SquareImageModel(
                    urlImage: model.userModel.image,
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
            )),
        model.color == CustomChatColor.dark ? Expanded(
          flex: 0,
          child: Text(dateFormatHour(model.chatModel.dateCreate)),
        ) : Container(),
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
