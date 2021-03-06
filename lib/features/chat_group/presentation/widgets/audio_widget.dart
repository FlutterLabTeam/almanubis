import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/download_image_widget.dart';

class AudioWidget extends StatelessWidget {

  final Size size;
  final DownloadImageWidgetColor color;

  const AudioWidget({Key? key,required this.size, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.5,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color:  _getColor(color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(5),
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: CompanyColor.color().third),
                child: Image.asset("assets/icons/music-file.png"),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text('00:00:00', style: _getColorLine(color),),
            )
          ],
      ),
    );
  }

  TextStyle _getColorLine(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.dark:
        return CompanyFontStyle.style().titleStyleLight;
      case DownloadImageWidgetColor.light:
        return CompanyFontStyle.style().titleStyleDark;
    }
  }

  Color _getColor(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.light:
        return CompanyColor.color().second80;
      case DownloadImageWidgetColor.dark:
        return CompanyColor.color().primary80;
    }
  }

}
