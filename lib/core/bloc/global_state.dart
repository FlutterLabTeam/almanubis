part of 'global_bloc.dart';

abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class TakeImageState extends GlobalState {

  final String path;

  TakeImageState({required this.path});
}

class TakeImageErrorState extends GlobalState {}

class TakeImageLoadingState extends GlobalState {}

class SaveImageState extends GlobalState {

  final String link;

  SaveImageState({required this.link});
}

class SaveImageErrorState extends GlobalState {}

class SaveImageLoadingState extends GlobalState {}

class DownloadImageState extends GlobalState {}

class DownloadImageErrorState extends GlobalState {}

class DownloadImageLoadingState extends GlobalState {}
