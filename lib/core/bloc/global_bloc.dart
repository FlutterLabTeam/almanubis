import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/domain/use_cases/save_image.dart';
import 'package:almanubis/core/domain/use_cases/take_photo.dart';
import 'package:almanubis/core/domain/use_cases/update_image.dart';
import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:almanubis/core/domain/use_cases/download_image.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final TakePhoto takePhoto;
  final SaveImage saveImage;
  final UpdateImage updateImage;
  final DownloadImage downloadImage;

  GlobalBloc({
    required this.takePhoto,
    required this.saveImage,
    required this.updateImage,
    required this.downloadImage,
  }) : super(GlobalInitial());

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
    if (event is TakeImageEvent) {
      yield TakeImageLoadingState();
      dynamic result;
      if (event.isPhoto!) {
        result = await takePhoto(event.imageQualityModel);
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
    if (event is UpdateImageEvent) {
      yield SaveImageLoadingState();
      final result = await updateImage(
        UpdateImageParams(
          folderDB: event.folderDB,
          linkImage: event.link,
          path: event.path,
          idUser: event.idUser,
        ),
      );
      yield* result.fold((failure) async* {
        yield SaveImageErrorState();
      }, (String link) async* {
        yield SaveImageState(link: link);
      });
    }
    if (event is DisposeEvent) {
      yield GlobalInitial();
    }
    if (event is DownloadImageEvent) {
      yield DownloadImageLoadingState();
      final result = await downloadImage(DownloadImageParams(
        folderDB: event.folderDB,
        path: event.path,
      ));
      yield* result.fold((failure) async* {
        yield DownloadImageErrorState();
      }, (bool link) async* {
        yield DownloadImageState();
      });
    }
  }
}
