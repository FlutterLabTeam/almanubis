import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class CartVideoInputPresentation extends StatelessWidget {

  final Size size;
  final Future<void> initializeVideoPlayerFuture;
  final VideoPlayerController videoPlayerController;

  const CartVideoInputPresentation({
    Key? key,
    required this.size,
    required this.videoPlayerController,
    required this.initializeVideoPlayerFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.01,
      ),
      width: size.height * 0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: FutureBuilder(
        future: initializeVideoPlayerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: VideoPlayer(videoPlayerController),
          );
        },
      ),
    );
  }
}
