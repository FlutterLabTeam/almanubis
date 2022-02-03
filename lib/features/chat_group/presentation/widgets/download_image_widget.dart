import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/link_image_to_name.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/audio_widget.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/image_widget.dart';

enum ElementToDownload {
  image,
  video,
  audio,
}

enum DownloadImageWidgetColor {
  light,
  dark,
}

class DownloadImageWidgetModel {
  final String image;
  final Function(String) downloadImage;
  final DownloadImageWidgetColor color;
  final ElementToDownload? elementToDownload;

  DownloadImageWidgetModel({
    required this.image,
    required this.color,
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
            if(snapshot.data!.isEmpty){
              return GestureDetector(
                onTap: ()=> model.downloadImage(model.image),
                child: handledGenerateWidgetDownload(model.elementToDownload!, size),
              );
            }
            String urlImage = snapshot.data!;
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                    File(urlImage),
                  ),
                ),
              ),
              height: size.height * 0.3,
              width: size.width * 0.4,
            );
          }
          return const CircularProgressIndicator();
        });
  }

  Future<String> getImage() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    String link = "${dir.path}/${linkImageToName(model.image)}";
    link = link.replaceAll("/imageChat", "");
    bool validate = await File(link).exists();
    if(!validate) link = "";
    return link;
  }

  Color _getColor(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.light:
        return CompanyColor.color().second;
      case DownloadImageWidgetColor.dark:
        return CompanyColor.color().primary;
    }
  }

  Widget handledGenerateWidgetDownload(
      ElementToDownload elementToDownload, Size size) {
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
}
