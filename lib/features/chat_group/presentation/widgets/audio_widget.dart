import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/download_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              child: Container(
                height: 5,
                width: double.infinity,
                decoration: BoxDecoration(
                color: _getColorLine(color),
                  borderRadius: BorderRadius.circular(5)
                ),
                margin: const EdgeInsets.only(right: 10),
              ),
            )
          ],
      ),
    );
  }

  Color _getColorLine(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.dark:
        return CompanyColor.color().second;
      case DownloadImageWidgetColor.light:
        return CompanyColor.color().primary;
    }
  }

  Color _getColor(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.light:
        return CompanyColor.color().second;
      case DownloadImageWidgetColor.dark:
        return CompanyColor.color().primary;
    }
  }

}
