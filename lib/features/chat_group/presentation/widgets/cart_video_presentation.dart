import 'dart:io';

import 'package:almanubis/core/bloc/global_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class CartVideoPresentation extends StatefulWidget {

  final Size size;
  final String videoPath;

  const CartVideoPresentation({
    Key? key,
    required this.size,
    required this.videoPath
  })
      : super(key: key);

  @override
  State<CartVideoPresentation> createState() => _CartVideoPresentationState();
}

class _CartVideoPresentationState extends State<CartVideoPresentation> {

  static late Future<void> initializeVideoPlayerFuture;
  static late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    initializeVideoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handledActiveVideo(),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: widget.size.height * 0.01,
          horizontal: widget.size.width * 0.01,
        ),
        height: widget.size.height * 0.3,
        width: widget.size.width * 0.4,
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
      ),
    );
  }

  handledActiveVideo(){
    if(videoPlayerController.value.isPlaying){
      videoPlayerController.pause();
    }else{
      videoPlayerController.play();
    }
    BlocProvider.of<GlobalBloc>(context).add(DisposeEvent());
  }
}
