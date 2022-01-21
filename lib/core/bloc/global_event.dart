part of 'global_bloc.dart';

@immutable
abstract class GlobalEvent {}

class TakeImageEvent implements GlobalEvent {
  final bool? isPhoto;

  TakeImageEvent({this.isPhoto = true});
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
