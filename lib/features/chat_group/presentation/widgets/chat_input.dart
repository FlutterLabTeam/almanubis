import 'package:almanubis/core/components/input_chat/input_chat.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final bool isSend;
  static late Size size;
  final String? labelInput;
  final Function(String) handledChangeInput;
  final TextEditingController controller;

  const ChatInput({
    Key? key,
    this.labelInput,
    required this.isSend,
    required this.controller,
    required this.handledChangeInput
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: CompanyColor.color().primary,
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.link,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InputChat(
              model: InputChatColorModel(
                controller: controller,
                label: labelInput ?? "Mensaje",
                  handledChangeInput: (String text){
                    handledChangeInput(text);
                  }
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              color: CompanyColor.color().primary,
              width: size.width * 0.18,
              height: size.width * 0.17,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              color: CompanyColor.color().second,
              width: size.width * 0.18,
              height: size.width * 0.17,
              child: isSend
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mic,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
