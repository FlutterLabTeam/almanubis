part of 'chat_group_bloc.dart';

abstract class ChatGroupState {}

class ChatGroupInitial extends ChatGroupState {}

class GetChatGroupStreamState extends ChatGroupState {
  final Stream<QuerySnapshot> stream;

  GetChatGroupStreamState({required this.stream});
}

class GetChatGroupStreamLoadingState extends ChatGroupState {}

class GetChatGroupStreamErrorState extends ChatGroupState {}

class CreateChatState extends ChatGroupState {}

class CreateChatLoadingState extends ChatGroupState {}

class CreateChatErrorState extends ChatGroupState {}

class SaveAudioState extends ChatGroupState {
  final String path;

  SaveAudioState({required this.path});
}

class SaveAudioLoadingState extends ChatGroupState {}

class SaveAudioErrorState extends ChatGroupState {}


class SaveVideoState extends ChatGroupState {
  final String path;

  SaveVideoState({required this.path});
}

class SaveVideoLoadingState extends ChatGroupState {}

class SaveVideoErrorState extends ChatGroupState {}
