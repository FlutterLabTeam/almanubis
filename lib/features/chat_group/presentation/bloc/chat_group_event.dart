part of 'chat_group_bloc.dart';

@immutable
abstract class ChatGroupEvent {}

class GetChatStreamEvent implements ChatGroupEvent {
  final String idGroup;

  GetChatStreamEvent({
    required this.idGroup,
  });
}

class CreateChatEvent implements ChatGroupEvent {
  final ChatModel chatModel;

  CreateChatEvent({
    required this.chatModel,
  });
}

class InitBlocEvent implements ChatGroupEvent {}
