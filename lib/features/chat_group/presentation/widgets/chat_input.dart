import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/data/models/element_to_download.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/cart_image_chat.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/text_input_option.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/audio_input_option.dart';

enum ChatInputType {
  textOption,
  audioOption,
}

class ChatInput extends StatelessWidget {
  final bool isSend;
  final String counter;
  static late Size size;
  final String? labelInput;
  final bool loadingButton;
  final Function() saveAudio;
  final Function() saveVideo;
  final List<String> mediaList;
  final Function() handledTapCamara;
  final Function() handledPlayAudio;
  final ChatInputType typeInputChat;
  final Function() handledSubmitChat;
  final Function() handledDeleteAudio;
  final Function() handledListenAudio;
  final Function() handledStopRecorder;
  final AudioInputState audioInputState;
  final TextEditingController controller;
  final Function(dynamic) handledTapOption;
  final ElementToDownload elementToDownload;
  final Function(String) handledDeleteImage;
  final Function(String) handledChangeInput;

  const ChatInput({
    Key? key,
    this.labelInput,
    required this.isSend,
    required this.counter,
    required this.mediaList,
    required this.saveVideo,
    required this.saveAudio,
    required this.controller,
    required this.loadingButton,
    required this.typeInputChat,
    required this.audioInputState,
    required this.handledTapOption,
    required this.handledPlayAudio,
    required this.handledTapCamara,
    required this.elementToDownload,
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
      margin: EdgeInsets.only(
        right: size.width * 0.04,
        left: size.width * 0.04,
        bottom: size.height * 0.02,
      ),
      width: size.width,
      color: CompanyColor.color().primary90,
      child: Column(
        children: [
          handledSelectedTypeInput(typeInputChat),
          mediaList.isNotEmpty
              ? SizedBox(
                  height: size.height*0.1,
                  width: size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: mediaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String image = mediaList[index];
                      return CartImageChat(
                        imagePath: image,
                        elementToDownload: elementToDownload,
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
          saveVideo: saveVideo,
          controller: controller,
          loadingButton: loadingButton,
          labelInput: labelInput ?? "Mensaje",
          handledPlayAudio: handledPlayAudio,
          handledTapOption: handledTapOption,
          handledTapCamara: handledTapCamara,
          handledSubmitChat: handledSubmitChat,
          elementToDownload: elementToDownload,
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
