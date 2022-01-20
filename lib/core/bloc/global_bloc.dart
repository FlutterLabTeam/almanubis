import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/use_cases/save_image.dart';
import 'package:almanubis/core/domain/use_cases/take_photo.dart';
import 'package:almanubis/core/domain/use_cases/update_image.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final TakePhoto takePhoto;
  final SaveImage saveImage;
  final UpdateImage updateImage;

  GlobalBloc({
    required this.takePhoto,
    required this.saveImage,
    required this.updateImage,
  }) : super(GlobalInitial());

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
    if (event is TakeImageEvent) {
      yield TakeImageLoadingState();
      dynamic result;
      if (event.isPhoto!) {
        result = await takePhoto(NoParams());
      } else {
        /*result = await takeImage();*/
      }
      yield* result.fold((failure) async* {
        yield TakeImageErrorState();
      }, (String path) async* {
        yield TakeImageState(path: path);
      });
    }
    if (event is SaveImageEvent) {
      yield SaveImageLoadingState();
      final result = await saveImage(
        SaveImageParams(
          folderDB: event.folderDB,
          idUser: event.idUser,
          path: event.path,
        ),
      );
      yield* result.fold((failure) async* {
        yield SaveImageErrorState();
      }, (String link) async* {
        yield SaveImageState(link: link);
      });
    }
  }
}