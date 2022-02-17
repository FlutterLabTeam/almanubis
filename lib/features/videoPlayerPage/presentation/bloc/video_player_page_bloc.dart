import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_player_page_state.dart';

part 'video_player_page_event.dart';

class VideoPlayerPageBloc extends Bloc<VideoPlayerPageEvent, VideoPlayerPageState> {
  VideoPlayerPageBloc() : super(VideoPlayInitState());

  @override
  Stream<VideoPlayerPageState> mapEventToState(
      VideoPlayerPageEvent event,
  ) async* {
    if (event is InitBlocEvent) {
      yield VideoPlayInitState();
      yield VideoPlayPageState();
    }
  }
}
