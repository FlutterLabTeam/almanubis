import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PanelVideo extends StatelessWidget {
  final Size size;
  final String time;
  final Function handledTapVolume;
  final Function handledActiveVideo;
  final Function(double, bool) setPlaybackSpeed;
  final VideoPlayerController controller;

  const PanelVideo({
    Key? key,
    required this.size,
    required this.time,
    required this.controller,
    required this.setPlaybackSpeed,
    required this.handledTapVolume,
    required this.handledActiveVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.03),
      width: size.width * 0.9,
      height: size.height * 0.1,
      decoration: BoxDecoration(
          color: CompanyColor.color().second,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 1),
              spreadRadius: 2,
              blurRadius: 3,
            )
          ]),
      child: Row(
        children: [
          generateIcons(
            icon: controller.value.volume == 1
                ? Icons.volume_up_rounded
                : Icons.volume_off_sharp,
            handled: handledTapVolume,
          ),
          generateIcons(icon: Icons.fast_rewind, handled: () => setPlaybackSpeed(0.3, false)),
          generateIcons(
            icon: controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            handled: handledActiveVideo,
          ),
          generateIcons(icon: Icons.fast_forward, handled: ()  => setPlaybackSpeed(0.3, true)),
          Expanded(
            child: Text(time.toString(), style: CompanyFontStyle.style().textCartDarkStyle,),
          )
        ],
      ),
    );
  }

  Widget generateIcons({required IconData icon, required Function handled}) {
    return Expanded(
      child: IconButton(
        onPressed: () => handled(),
        icon: Icon(icon),
      ),
    );
  }
}
