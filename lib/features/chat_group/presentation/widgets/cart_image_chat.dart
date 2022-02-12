import 'dart:io';

import 'package:almanubis/features/chat_group/data/models/element_to_download.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/cart_image_input_presentation.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/cart_video_input_presentation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CartImageChat extends StatefulWidget {
  final String imagePath;
  final ElementToDownload elementToDownload;
  final Function(String) handledDeleteImage;

  const CartImageChat({
    Key? key,
    required this.imagePath,
    required this.elementToDownload,
    required this.handledDeleteImage,
  }) : super(key: key);

  @override
  State<CartImageChat> createState() => _CartImageChatState();
}

class _CartImageChatState extends State<CartImageChat> {
  static late Size size;
  static late Future<void> initializeVideoPlayerFuture;
  static late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(File(widget.imagePath));
    initializeVideoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        widget.elementToDownload == ElementToDownload.image
            ? CartImageInputPresentation(
                size: size,
                pathImage: widget.imagePath,
              )
            : CartVideoInputPresentation(
                size: size,
                videoPlayerController: videoPlayerController,
                initializeVideoPlayerFuture: initializeVideoPlayerFuture,
              ),
        GestureDetector(
          onTap: () => widget.handledDeleteImage(widget.imagePath),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close),
          ),
        )
      ],
    );
  }
}
