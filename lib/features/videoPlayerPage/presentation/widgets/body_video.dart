import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BodyVideo extends StatelessWidget {
  final Size size;
  final Widget body;
  final Function handledTap;
  final VideoPlayerController controller;

  const BodyVideo({
    Key? key,
    required this.body,
    required this.size,
    required this.controller,
    required this.handledTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        body,
        iconGenerate(),
        Positioned(
          top: size.height * 0.1,
          left: size.width * 0.1,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: size.height * 0.05,
              color: CompanyColor.color().third,
            ),
          ),
        )
      ],
    );
  }

  Widget iconGenerate() {
    if (controller.value.isPlaying) {
      return Container();
    }
    return GestureDetector(
      onTap: () => handledTap(),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CompanyColor.color().third, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black45, spreadRadius: 3)
            ]),
        child: Icon(
          Icons.play_arrow,
          size: 70,
          color: CompanyColor.color().third,
        ),
      ),
    );
  }
}
