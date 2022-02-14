import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BodyVideo extends StatelessWidget {
  final Widget body;
  final VideoPlayerController controller;
  final Function handledTap;

  const BodyVideo({
    Key? key,
    required this.body,
    required this.controller,
    required this.handledTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        body,
        iconGenerate()
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
            border: Border.all(
                color: CompanyColor
                    .color()
                    .third,
                width: 2
            ),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 3
              )
            ]
        ),
        child: Icon(
          Icons.play_arrow,
          size: 70,
          color: CompanyColor
              .color()
              .third,
        ),
      ),
    );
  }
}
