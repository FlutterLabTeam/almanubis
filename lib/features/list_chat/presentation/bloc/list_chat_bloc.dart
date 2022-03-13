import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/features/list_chat/domain/use_cases/get_list_chat_data.dart';
import 'package:almanubis/features/list_chat/domain/use_cases/get_list_chat_snapshot.dart';

part 'list_chat_event.dart';

part 'list_chat_state.dart';

class ListChatBloc extends Bloc<ListChatEvent, ListChatState> {
  final GetListChat getListChat;
  final GetListGroupSnapShot getListGroupSnapShot;

  ListChatBloc({
    required this.getListChat,
    required this.getListGroupSnapShot,
  }) : super(ListChatInitial());

  @override
  Stream<ListChatState> mapEventToState(
    ListChatEvent event,
  ) async* {
    if (event is GetAllListGroupStreamEvent) {
      yield GetAllListChatLoadingState();
      final result = await getListGroupSnapShot(GetListChatSnapShotParams(
        userId: event.userId,
        isAdmin: event.isAdmin,
      ),);
      yield* result.fold((failure) async* {
        yield GetAllListChatErrorState();
      }, (Stream<QuerySnapshot> listChat) async* {
        yield GetAllListChatStreamState(stream: listChat);
      });
    }

    if (event is GetAllListChatEvent) {
      yield GetAllListChatLoadingState();
      final result = await getListChat(event.userId);
      yield* result.fold((failure) async* {
        yield GetAllListChatErrorState();
      }, (List<ChatModel> listChat) async* {
        yield GetAllListChatState(listChatModel: listChat);
      });
    }
    if (event is ListChatInitialEvent) {
      yield GetAllListChatLoadingState();
      yield ListChatInitial();

    }
  }
}
