part of 'list_chat_bloc.dart';

@immutable
abstract class ListChatEvent {}

class GetAllListChatEvent implements ListChatEvent {
  final String userId;

  GetAllListChatEvent({required this.userId});
}

class GetAllListGroupStreamEvent implements ListChatEvent {
  final String userId;
  final bool isAdmin;

  GetAllListGroupStreamEvent({
    required this.userId,
    required this.isAdmin,
  });
}

class ListChatInitialEvent implements ListChatEvent{}
