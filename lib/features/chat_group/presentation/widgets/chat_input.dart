import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/audio_input_option.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/cart_image_chat.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/text_input_option.dart';

enum ChatInputType {
  textOption,
  audioOption,
}

class ChatInput extends StatelessWidget {
  final bool isSend;
  final String counter;
  static late Size size;
  final bool loadingButton;
  final Function saveAudio;
  final String? labelInput;
  final List<String> mediaList;
  final Function handledTapCamara;
  final Function handledPlayAudio;
  final ChatInputType typeInputChat;
  final Function handledDeleteAudio;
  final Function handledListenAudio;
  final Function handledStopRecorder;
  final Function() handledSubmitChat;
  final AudioInputState audioInputState;
  final TextEditingController controller;
  final Function(String) handledDeleteImage;
  final Function(String) handledChangeInput;

  const ChatInput({
    Key? key,
    this.labelInput,
    required this.isSend,
    required this.counter,
    required this.mediaList,
    required this.saveAudio,
    required this.controller,
    required this.loadingButton,
    required this.typeInputChat,
    required this.audioInputState,
    required this.handledPlayAudio,
    required this.handledTapCamara,
    required this.handledSubmitChat,
    required this.handledListenAudio,
    required this.handledDeleteAudio,
    required this.handledChangeInput,
    required this.handledDeleteImage,
    required this.handledStopRecorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: CompanyColor.color().primary,
      child: Column(
        children: [
          handledSelectedTypeInput(typeInputChat),
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

  Widget handledSelectedTypeInput(ChatInputType chatInputType) {
    switch (chatInputType) {
      case ChatInputType.textOption:
        return TextInputOption(
          size: size,
          isSend: isSend,
          mediaList: mediaList,
          controller: controller,
          labelInput: labelInput??"Mensaje",
          loadingButton: loadingButton,
          handledPlayAudio: handledPlayAudio,
          handledTapCamara: handledTapCamara,
          handledSubmitChat: handledSubmitChat,
          handledChangeInput: handledChangeInput,
        );
      case ChatInputType.audioOption:
        return AudioInputOption(
          size: size,
          isSend: isSend,
          counter: counter,
          mediaList: mediaList,
          saveAudio: saveAudio,
          loadingButton: loadingButton,
          audioInputState: audioInputState,
          handledPlayAudio: handledPlayAudio,
          handledSubmitAudio: handledSubmitChat,
          handledDeleteAudio: handledDeleteAudio,
          handledListenAudio: handledListenAudio,
          handledStopRecorder: handledStopRecorder,
        );
    }
  }
}
