part of 'list_chat_bloc.dart';

abstract class ListChatState {}

class ListChatInitial extends ListChatState {}

class GetAllListChatStreamState extends ListChatState {
  final Stream<QuerySnapshot> stream;

  GetAllListChatStreamState({required this.stream});
}

class GetAllListChatState extends ListChatState {
  final List<ChatModel> listChatModel;

  GetAllListChatState({required this.listChatModel});
}

class GetAllListChatLoadingState extends ListChatState {}

class GetAllListChatErrorState extends ListChatState {}
