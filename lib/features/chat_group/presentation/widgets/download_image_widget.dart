import 'dart:io';
import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/cart_video_presentation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/link_image_to_name.dart';
import 'package:almanubis/features/chat_group/data/models/element_to_download.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/audio_widget.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/image_widget.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/presentation_audio_assets.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/presentation_image_assets.dart';

enum DownloadImageWidgetColor {
  light,
  dark,
}

class DownloadImageWidgetModel {
  final String image;
  final ChatModel chatModel;
  final Function(ChatModel) playAudio;
  final Function(String) downloadImage;
  final Function(String) downloadAudio;
  final Function(String) downloadVideo;
  final DownloadImageWidgetColor color;
  final ElementToDownload? elementToDownload;

  DownloadImageWidgetModel({
    required this.image,
    required this.color,
    required this.chatModel,
    required this.playAudio,
    required this.downloadVideo,
    required this.downloadAudio,
    required this.downloadImage,
    this.elementToDownload = ElementToDownload.image,
  });
}

class DownloadImageWidget extends StatelessWidget {
  static late Size size;
  final DownloadImageWidgetModel model;

  const DownloadImageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getImage(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return GestureDetector(
                onTap: () {
                  if (model.elementToDownload == ElementToDownload.image) {
                    model.downloadImage(model.image);
                  }
                  if (model.elementToDownload == ElementToDownload.audio) {
                    model.downloadAudio(model.image);
                  }
                  if (model.elementToDownload == ElementToDownload.video) {
                    model.downloadVideo(model.image);
                  }
                },
                child: handledGenerateWidgetDownload(
                  size: size,
                  elementToDownload: model.elementToDownload!,
                ),
              );
            }
            String urlAssets = snapshot.data!;
            return handledGenerateWidgetAssets(
              size: size,
              context: context,
              urlAssets: urlAssets,
              elementToDownload: model.elementToDownload!,
            );
          }
          return const CustomCircularProgressIndicator();
        });
  }

  Future<String> getImage() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    String link = "${dir.path}/${linkImageToName(model.image)}";
    link = link.replaceAll("/imageChat", "");
    link = link.replaceAll("/audio", "");
    link = link.replaceAll("/video", "");
    bool validate = await File(link).exists();
    if (!validate) link = "";
    return link;
  }

  Color _getColor(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.light:
        return CompanyColor.color().second80;
      case DownloadImageWidgetColor.dark:
        return CompanyColor.color().primary80;
    }
  }

  Widget handledGenerateWidgetDownload({
    required Size size,
    required ElementToDownload elementToDownload,
  }) {
    switch (elementToDownload) {
      case ElementToDownload.image:
        return ImageWidget(
            elementToDownload: elementToDownload,
            size: size,
            color: _getColor(model.color));
      case ElementToDownload.video:
        return ImageWidget(
            elementToDownload: elementToDownload,
            size: size,
            color: _getColor(model.color));
      case ElementToDownload.audio:
        return AudioWidget(size: size, color: model.color);
    }
  }

  Widget handledGenerateWidgetAssets({
    required Size size,
    required String urlAssets,
    required BuildContext context,
    required ElementToDownload elementToDownload,
  }) {
    switch (elementToDownload) {
      case ElementToDownload.image:
        return PresentationImageAssets(
          size: size,
          urlAssets: urlAssets,
        );
      case ElementToDownload.video:
        return CartVideoPresentation(
            size: size,
            videoPath: urlAssets,
        );
      case ElementToDownload.audio:
        return PresentationAudioAssets(
          size: size,
          color: model.color,
          playAudio: model.playAudio,
          chatModel: model.chatModel,
        );
    }
  }


}
