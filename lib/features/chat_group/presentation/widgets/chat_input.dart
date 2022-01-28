import 'package:almanubis/core/components/input_chat/input_chat.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/cart_image_chat.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final bool isSend;
  static late Size size;
  final bool loadingButton;
  final String? labelInput;
  final List<String> mediaList;
  final Function handledTapCamara;
  final Function() handledSubmitChat;
  final TextEditingController controller;
  final Function(String) handledDeleteImage;
  final Function(String) handledChangeInput;

  const ChatInput({
    Key? key,
    this.labelInput,
    required this.isSend,
    required this.mediaList,
    required this.controller,
    required this.loadingButton,
    required this.handledTapCamara,
    required this.handledSubmitChat,
    required this.handledChangeInput,
    required this.handledDeleteImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: CompanyColor.color().primary,
      child: Column(
        children: [
          Row(
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
                      handledChangeInput: (String text) {
                        handledChangeInput(text);
                      }),
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  color: CompanyColor.color().primary,
                  width: size.width * 0.18,
                  height: size.width * 0.17,
                  child: IconButton(
                    onPressed: () => handledTapCamara(),
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
                  child: !loadingButton
                      ? isSend || mediaList.isNotEmpty
                          ? IconButton(
                              onPressed: () => handledSubmitChat(),
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
                            )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.045,
                            vertical: size.width * 0.04,
                          ),
                          child: const CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
          mediaList.isNotEmpty
              ? SizedBox(
                  height: size.height * 0.11,
                  width: size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: mediaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String image = mediaList[index];
                      return CartImageChat(
                        imagePath: image,
                        handledDeleteImage: handledDeleteImage,
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
