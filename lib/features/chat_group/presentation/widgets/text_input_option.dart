import 'package:almanubis/features/chat_group/data/models/element_to_download.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/components/input_chat/input_chat.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/dropdown_button_widget.dart';

class TextInputOption extends StatelessWidget {
  final Size size;
  final bool isSend;
  final String labelInput;
  final bool loadingButton;
  final Function() saveVideo;
  final List<String> mediaList;
  final Function() handledTapCamara;
  final Function(dynamic) handledTapOption;
  final Function() handledPlayAudio;
  final Function() handledSubmitChat;
  final TextEditingController controller;
  final ElementToDownload elementToDownload;
  final Function(String) handledChangeInput;

  const TextInputOption({
    Key? key,
    required this.size,
    required this.isSend,
    required this.mediaList,
    required this.saveVideo,
    required this.controller,
    required this.labelInput,
    required this.loadingButton,
    required this.handledPlayAudio,
    required this.handledTapOption,
    required this.handledTapCamara,
    required this.elementToDownload,
    required this.handledSubmitChat,
    required this.handledChangeInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButtonWidget(
              handledTapInOption: handledTapOption,
              listElement: const [Icons.image, Icons.videocam],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InputChat(
            model: InputChatColorModel(
                controller: controller,
                label: labelInput,
                handledChangeInput: (String text) => handledChangeInput(text)),
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
                        onPressed: () {
                          elementToDownload == ElementToDownload.image
                              ? handledSubmitChat()
                              : saveVideo();
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    : IconButton(
                        onPressed: () => handledPlayAudio(),
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
    );
  }
}
