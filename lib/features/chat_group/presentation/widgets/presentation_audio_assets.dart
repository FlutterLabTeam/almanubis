import 'package:almanubis/core/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/download_image_widget.dart';

class PresentationAudioAssets extends StatelessWidget {
  final Size size;
  final ChatModel chatModel;
  final DownloadImageWidgetColor color;
  final Function(ChatModel) playAudio;

  const PresentationAudioAssets({
    Key? key,
    required this.size,
    required this.color,
    required this.chatModel,
    required this.playAudio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = chatModel.dataAsset.counted! != 0
        ? chatModel.dataAsset.counted!
        : chatModel.dataAsset.millisecondTime;

    var date = DateTime.fromMillisecondsSinceEpoch(
      count,
      isUtc: false,
    );
    var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
    String timeString = txt.substring(0, 8);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
      ),
      decoration: BoxDecoration(
        color: _getColor(color),
        borderRadius: BorderRadius.circular(20),
      ),
      height: size.height * 0.1,
      width: size.width * 0.5,
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () => playAudio(chatModel),
              child: Container(
                padding: const EdgeInsets.all(9),
                margin: const EdgeInsets.all(5),
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CompanyColor.color().third,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 32,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timeString,
              style: _getColorLine(color),
            ),
          )
        ],
      ),
    );
  }

  Color _getColor(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.light:
        return CompanyColor.color().second;
      case DownloadImageWidgetColor.dark:
        return CompanyColor.color().primary;
    }
  }

  TextStyle _getColorLine(DownloadImageWidgetColor color) {
    switch (color) {
      case DownloadImageWidgetColor.dark:
        return CompanyFontStyle.style().titleStyleLight;
      case DownloadImageWidgetColor.light:
        return CompanyFontStyle.style().titleStyleDark;
    }
  }
}
