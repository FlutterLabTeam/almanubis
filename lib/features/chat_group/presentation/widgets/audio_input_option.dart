import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';

enum AudioInputState { recording, slow, listening }

class AudioInputOption extends StatelessWidget {
  final Size size;
  final bool isSend;
  final String counter;
  final bool loadingButton;
  final Function() saveAudio;
  final List<String> mediaList;
  final Function() handledPlayAudio;
  final Function() handledSubmitAudio;
  final Function() handledDeleteAudio;
  final Function() handledListenAudio;
  final Function() handledStopRecorder;
  final AudioInputState audioInputState;

  const AudioInputOption({
    Key? key,
    required this.size,
    required this.isSend,
    required this.counter,
    required this.saveAudio,
    required this.mediaList,
    required this.loadingButton,
    required this.audioInputState,
    required this.handledPlayAudio,
    required this.handledSubmitAudio,
    required this.handledStopRecorder,
    required this.handledDeleteAudio,
    required this.handledListenAudio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 0, child: handledControllingEngravingIcon(audioInputState)),
        Expanded(
          flex: 0,
          child: handledControllingAudioIcon(audioInputState),
        ),
        Expanded(
            flex: 1,
            child: Text(
              counter,
              style: CompanyFontStyle.style().titleStyleLight,
            )),
        Expanded(
          flex: 0,
          child: Container(
            color: CompanyColor.color().primary80,
            width: size.width * 0.18,
            height: size.width * 0.15,
            child: IconButton(
              onPressed: () => handledDeleteAudio(),
              icon: const Icon(
                Icons.delete,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            width: size.width * 0.15,
            height: size.width * 0.15,
            color: CompanyColor.color().second,
            child: !loadingButton
                ? IconButton(
                    onPressed: () => saveAudio(),
                    icon: const Icon(
                      Icons.send,
                      size: 25,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.045,
                      vertical: size.width * 0.04,
                    ),
                    child: const CustomCircularProgressIndicator(),
                  ),
          ),
        ),
      ],
    );
  }

  Widget handledControllingEngravingIcon(AudioInputState audioInputState) {
    switch (audioInputState) {
      case AudioInputState.recording:
        return handledIcon(
            icon: Icons.pause,
            color: const Color(0xffd79090),
            handled: () => handledStopRecorder());
      case AudioInputState.slow:
        return handledIcon(
            icon: Icons.mic,
            color: Colors.greenAccent,
            handled: () => handledPlayAudio());
      case AudioInputState.listening:
        return handledIcon(icon: Icons.mic, color: Colors.grey, handled: () {});
    }
  }

  Widget handledControllingAudioIcon(AudioInputState audioInputState) {
    switch (audioInputState) {
      case AudioInputState.recording:
        return handledIcon(
            icon: Icons.volume_up_rounded,
            color: const Color(0xc47e7e7e),
            handled: () {});
      case AudioInputState.slow:
        return handledIcon(
            icon: Icons.volume_up_rounded,
            color: Colors.white,
            handled: () => handledListenAudio());
      case AudioInputState.listening:
        return handledIcon(
            icon: Icons.volume_up_rounded,
            color: Colors.greenAccent,
            handled: () => handledListenAudio());
    }
  }

  handledIcon({
    required IconData icon,
    required Color color,
    required Function() handled,
  }) {
    return IconButton(
      onPressed: () => handled(),
      icon: Icon(
        icon,
        size: 25,
        color: color,
      ),
    );
  }
}
