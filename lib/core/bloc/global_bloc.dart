import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/use_cases/take_image.dart';
import 'package:almanubis/core/domain/use_cases/take_video.dart';
import 'package:almanubis/core/domain/use_cases/save_image.dart';
import 'package:almanubis/core/domain/use_cases/take_photo.dart';
import 'package:almanubis/core/domain/use_cases/update_image.dart';
import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:almanubis/core/domain/use_cases/download_image.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final TakePhoto takePhoto;
  final TakeImage takeImage;
  final SaveImage saveImage;
  final TakeVideo takeVideo;
  final UpdateImage updateImage;
  final DownloadAssets downloadAssets;

  GlobalBloc({
    required this.takePhoto,
    required this.saveImage,
    required this.takeImage,
    required this.takeVideo,
    required this.updateImage,
    required this.downloadAssets,
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
        result = await takeImage(event.imageQualityModel);
      }
      yield* result.fold((failure) async* {
        yield TakeImageErrorState();
      }, (String path) async* {
        yield TakeImageState(path: path);
      });
    }
    if (event is TakeVideoEvent) {
      yield TakeImageLoadingState();
      dynamic result = await takeVideo(NoParams());
      yield* result.fold((failure) async* {
        yield TakeVideoErrorState();
      }, (String path) async* {
        yield TakeVideoState(path: path);
      });
    }
    if (event is InitStateGlobalEvent) {
      yield TakeImageLoadingState();
      yield GlobalInitial();
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
      yield TakeImageLoadingState();
      yield GlobalInitial();
    }
    if (event is DownloadAssetsEvent) {
      yield DownloadAssetsLoadingState(
        assetsImage: event.assetsName!
      );
      final result = await downloadAssets(DownloadAssetsParams(
        folderDB: event.folderDB,
        path: event.path,
      ));
      yield* result.fold((failure) async* {
        yield DownloadAssetsErrorState(
            assetsImage: event.assetsName!
        );
      }, (bool link) async* {
        yield DownloadAssetsState(
            assetsImage: event.assetsName!
        );
      });
    }
  }
}
