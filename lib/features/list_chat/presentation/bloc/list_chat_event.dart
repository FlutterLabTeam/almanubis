part of 'list_chat_bloc.dart';

@immutable
abstract class ListChatEvent {}

class GetAllListChatEvent implements ListChatEvent {
  final String userId;

  GetAllListChatEvent({required this.userId});
}

class GetAllListChatStreamEvent implements ListChatEvent {
  final String userId;
  final bool isAdmin;

  GetAllListChatStreamEvent({
    required this.userId,
    required this.isAdmin,
  });
}
