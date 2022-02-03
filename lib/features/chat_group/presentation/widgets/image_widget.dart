import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/download_image_widget.dart';
import 'package:flutter/cupertino.dart';

class ImageWidget extends StatelessWidget {
  final Size size;
  final Color color;
  final ElementToDownload elementToDownload;

  const ImageWidget({
    Key? key,
    required this.size,
    required this.color,
    required this.elementToDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color),
      height: size.height * 0.3,
      width: size.width * 0.4,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(25),
        height: size.height * 0.2,
        width: size.width * 0.3,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: CompanyColor.color().third),
        child: Image.asset(handledGenerateIconAssets(elementToDownload)),
      ),
    );
  }

  String handledGenerateIconAssets(ElementToDownload elementToDownload){
    switch(elementToDownload){
      case ElementToDownload.image:
        return "assets/icons/download.png";
      case ElementToDownload.video:
        return "assets/icons/downloading.png";
      case ElementToDownload.audio:
        return "assets/icons/music-file.png";
    }
  }
}
