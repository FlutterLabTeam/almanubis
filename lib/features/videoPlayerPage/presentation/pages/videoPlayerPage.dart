import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:video_player/video_player.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/features/videoPlayerPage/presentation/widgets/body_video.dart';
import 'package:almanubis/features/videoPlayerPage/presentation/widgets/panel_video.dart';
import 'package:almanubis/features/videoPlayerPage/presentation/bloc/video_player_page_bloc.dart';
import 'package:almanubis/features/videoPlayerPage/presentation/widgets/basic_overlay_widget.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoPath;

  const VideoPlayerView({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  static late Size size;
  static late String timeVideo = "00:00";
  static late double speedVideo = 1;
  static late Future<void> initializeVideoPlayerFuture;
  static late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.file(File(widget.videoPath));
    initializeVideoPlayerFuture = controller.initialize();
    controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    speedVideo = 1;
    timeVideo = "00:00";
    controller.setPlaybackSpeed(1);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CompanyColor.color().primary,
      body: BlocBuilder<VideoPlayerPageBloc, VideoPlayerPageState>(
        builder: (context, state) {
          return Column(
            children: [
              BodyVideo(
                body: SizedBox(
                  height: size.height * 0.8,
                  width: size.width,
                  child: GestureDetector(
                    onTap: () => handledActiveVideo(),
                    child: FutureBuilder(
                      future: initializeVideoPlayerFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        );
                      },
                    ),
                  ),
                ),
                handledTap: handledActiveVideo,
                controller: controller,
                size: size,
              ),
              BasicOverlayWidget(controller: controller),
              PanelVideo(
                  size: size,
                  time: timeVideo,
                  controller: controller,
                  handledTapVolume: handledTapVolume,
                  handledActiveVideo: handledActiveVideo,
                  setPlaybackSpeed: setPlaybackSpeed)
            ],
          );
        },
      ),
    );
  }

  handledActiveVideo() {
    handledGenerateTimeVideo();
    if (controller.value.isPlaying) {
      controller.pause();
      controller.setPlaybackSpeed(1);
      speedVideo = 1;
    } else {
      controller.play();
    }
    BlocProvider.of<VideoPlayerPageBloc>(context).add(InitBlocEvent());
  }

  handledTapVolume() {
    if (controller.value.volume == 0) {
      controller.setVolume(1);
    } else {
      controller.setVolume(0);
    }
    BlocProvider.of<VideoPlayerPageBloc>(context).add(InitBlocEvent());
  }

  handledGenerateTimeVideo() {
    controller.addListener(() {
      var datePosition = DateTime.fromMillisecondsSinceEpoch(
        controller.value.position.inMilliseconds,
        isUtc: true,
      );
      var dateDuration = DateTime.fromMillisecondsSinceEpoch(
        controller.value.duration.inMilliseconds,
        isUtc: true,
      );
      var txtPosition = DateFormat('m:ss', 'en_GB').format(datePosition);
      var txtDuration = DateFormat('m:ss', 'en_GB').format(dateDuration);
      timeVideo = "$txtPosition/$txtDuration";
      BlocProvider.of<VideoPlayerPageBloc>(context).add(InitBlocEvent());
    });
  }

  setPlaybackSpeed(double speed, bool increase) {
    if (increase) {
      speedVideo = speed + speedVideo;
    } else if (speedVideo > 0) {
      speedVideo = speedVideo - speed;
    }
    controller.setPlaybackSpeed(speedVideo);
  }
}
