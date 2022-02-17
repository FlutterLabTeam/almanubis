import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:almanubis/core/util/company_colors.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      colors: VideoProgressColors(
        playedColor: CompanyColor.color().second,
      ),
    );
  }
}
