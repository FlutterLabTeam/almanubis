import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/util/date_format.dart';
import 'package:almanubis/core/components/cart_chat/cart_chat.dart';
import 'package:almanubis/core/components/square_image/square_image.dart';
import 'package:almanubis/features/chat_group/data/models/element_to_download.dart';
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
  final Function(String) downloadVideo;

  CustomChatModel({
    required this.chatModel,
    required this.playAudio,
    required this.downloadImage,
    required this.downloadAudio,
    required this.downloadVideo,
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
        model.chatModel.label.isNotEmpty
            ? Row(
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
                          child: Text(
                            dateFormatHour(model.chatModel.dateCreate),
                            style: CompanyFontStyle.style().dateFont,
                          ),
                        ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: size.width * 0.02),
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
                          child: Text(
                            dateFormatHour(model.chatModel.dateCreate),
                            style: CompanyFontStyle.style().dateFont,
                          ),
                        )
                      : Container(),
                ],
              )
            : Container(),
        model.chatModel.dataAsset.urlAsset.isNotEmpty
            ? DownloadImageWidget(
                model: DownloadImageWidgetModel(
                  chatModel: model.chatModel,
                  playAudio: model.playAudio,
                  downloadAudio: model.downloadAudio,
                  downloadVideo: model.downloadVideo,
                  downloadImage: model.downloadImage,
                  image: model.chatModel.dataAsset.urlAsset,
                  color: handledGenerateAssetsColor(model.color!),
                  elementToDownload: handledGenerateAssetsType(
                      model.chatModel.dataAsset.typeAsset),
                ),
              )
            : Container(),
        model.color == CustomChatColor.light
            ? Container()
            : Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.15,
                  right: size.width * 0.15,
                  top: size.height * 0.002,
                  bottom: size.height * 0.007,
                ),
                child: Text(
                  model.chatModel.nameUser,
                  style: CompanyFontStyle.style().textCartChatDarkStyle,
                ),
              ),
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

  DownloadImageWidgetColor handledGenerateAssetsColor(
      CustomChatColor customChatColor) {
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
