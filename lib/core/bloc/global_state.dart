part of 'global_bloc.dart';

abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class TakeImageState extends GlobalState {
  final String path;

  TakeImageState({required this.path});
}

class TakeVideoState extends GlobalState {
  final String path;

  TakeVideoState({required this.path});
}

class TakeImageErrorState extends GlobalState {}

class TakeVideoErrorState extends GlobalState {}

class TakeImageLoadingState extends GlobalState {}

class SaveImageState extends GlobalState {
  final String link;

  SaveImageState({required this.link});
}

class SaveImageErrorState extends GlobalState {}

class SaveImageLoadingState extends GlobalState {}

class DownloadAssetsState extends GlobalState {
  final String assetsImage;

  DownloadAssetsState({required this.assetsImage});
}

class DownloadAssetsErrorState extends GlobalState {
  final String assetsImage;

  DownloadAssetsErrorState({required this.assetsImage});
}

class DownloadAssetsLoadingState extends GlobalState {
  final String assetsImage;

  DownloadAssetsLoadingState({required this.assetsImage});
}

class GetGroupDataState extends GlobalState {
  final GroupModel groupModel;

  GetGroupDataState({required this.groupModel});
}

class GetGroupLoadingState extends GlobalState {}

class GetGroupErrorState extends GlobalState {}
