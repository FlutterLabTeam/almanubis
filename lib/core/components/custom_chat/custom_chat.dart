import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/util/date_format.dart';
import 'package:almanubis/core/components/cart_chat/cart_chat.dart';
import 'package:almanubis/core/components/square_image/square_image.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/download_image_widget.dart';

enum CustomChatColor {
  light,
  dark,
}

class CustomChatModel {
  final ChatModel chatModel;
  final CustomChatColor? color;
  final Function(ChatModel) playAudio;
  final Function(String) downloadImage;
  final Function(String) downloadAudio;

  CustomChatModel({
    required this.chatModel,
    required this.playAudio,
    required this.downloadImage,
    required this.downloadAudio,
    this.color = CustomChatColor.dark,
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
      crossAxisAlignment: model.color == CustomChatColor.light
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        model.chatModel.label.isNotEmpty ? Row(
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
        ) : Container(),
        model.chatModel.dataAsset.urlAsset.isNotEmpty
            ? DownloadImageWidget(
                model: DownloadImageWidgetModel(
                  chatModel: model.chatModel,
                  playAudio: model.playAudio,
                  downloadAudio: model.downloadAudio,
                  downloadImage: model.downloadImage,
                  image: model.chatModel.dataAsset.urlAsset,
                  color: handledGenerateAssetsColor(model.color!),
                  elementToDownload: handledGenerateAssetsType(model.chatModel.dataAsset.typeAsset),
                ),
              )
            : Container()
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

  DownloadImageWidgetColor handledGenerateAssetsColor(CustomChatColor customChatColor) {
    switch (customChatColor) {
      case CustomChatColor.light:
        return DownloadImageWidgetColor.light;
      case CustomChatColor.dark:
        return DownloadImageWidgetColor.dark;
    }
  }

  ElementToDownload handledGenerateAssetsType(String type) {
    switch (type) {
      case "IMAGE":
        return ElementToDownload.image;
      case "AUDIO":
        return ElementToDownload.audio;
      case "VIDEO":
        return ElementToDownload.video;
      default:
        return ElementToDownload.image;
    }
  }
}
