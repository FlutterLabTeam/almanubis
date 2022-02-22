part of 'global_bloc.dart';

@immutable
abstract class GlobalEvent {}

class TakeImageEvent implements GlobalEvent {
  final bool? isPhoto;
  final ImageQualityModel imageQualityModel;

  TakeImageEvent({
    this.isPhoto = true,
    required this.imageQualityModel
  });
}

class SaveImageEvent implements GlobalEvent {
  final String path;
  final String? idUser;
  final String folderDB;

  SaveImageEvent({
    this.idUser,
    required this.path,
    required this.folderDB,
  });
}

class SaveVideoFileEvent implements GlobalEvent {
  final String path;
  final String? idUser;
  final String folderDB;

  SaveVideoFileEvent({
    this.idUser,
    required this.path,
    required this.folderDB,
  });
}

class TakeVideoEvent implements GlobalEvent {}

class DownloadAssetsEvent implements GlobalEvent {
  final String folderDB;
  final String path;
  final String? assetsName;

  DownloadAssetsEvent({
    required this.folderDB,
    required this.path,
    this.assetsName = "imagen",
  });
}

class UpdateImageEvent implements GlobalEvent {
  final String path;
  final String? idUser;
  final String folderDB;
  final String link;

  UpdateImageEvent({
    this.idUser,
    required this.path,
    required this.link,
    required this.folderDB,
  });
}

class DisposeEvent implements GlobalEvent {}
class InitStateGlobalEvent implements GlobalEvent {}
