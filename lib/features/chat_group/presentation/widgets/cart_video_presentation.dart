import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CartVideoPresentation extends StatelessWidget {
  final Size size;
  final String videoPath;

  const CartVideoPresentation({
    Key? key,
    required this.size,
    required this.videoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: generateImage(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        String url = snapshot.data!;
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
            horizontal: size.width * 0.1,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => handledTabVideo(videoPath, context),
                child: Container(
                  height: size.height * 0.3,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(url),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => handledTabVideo(videoPath, context),
                child: Container(
                  child: const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  handledTabVideo(String url, BuildContext context) {
    Navigator.pushNamed(context, '/videoPlayerView', arguments: url);
  }

  Future<String> generateImage() async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 300,
      maxWidth: 150,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );

    return fileName.toString();
  }
}


