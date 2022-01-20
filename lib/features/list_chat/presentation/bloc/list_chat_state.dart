part of 'list_chat_bloc.dart';

abstract class ListChatState {}

class ListChatInitial extends ListChatState {}

class GetAllListChatState extends ListChatState {
  final List<GroupModel> listChatModel;

  GetAllListChatState({required this.listChatModel});
}

class GetAllListChatLoadingState extends ListChatState {}

class GetAllListChatErrorState extends ListChatState {}
