import 'dart:async';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/features/chat_group/domain/use_cases/create_chat.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/features/chat_group/domain/use_cases/get_chat_stream.dart';

part 'chat_group_state.dart';
part 'chat_group_event.dart';

class ChatGroupBloc extends Bloc<ChatGroupEvent, ChatGroupState> {
  final GetChatStream getChatStream;
  final CreateChat createChat;

  ChatGroupBloc({
    required this.createChat,
    required this.getChatStream,
  }) : super(ChatGroupInitial());

  @override
  Stream<ChatGroupState> mapEventToState(
      ChatGroupEvent event,
      ) async* {
    if (event is GetChatStreamEvent) {
      yield GetChatGroupStreamLoadingState();
      final result = await getChatStream(event.idGroup);
      yield* result.fold((failure) async* {
        yield GetChatGroupStreamErrorState();
      }, (Stream<QuerySnapshot> stream) async* {
        yield GetChatGroupStreamState(stream: stream);
      });
    }
    if (event is CreateChatEvent) {
      yield CreateChatLoadingState();
      final result = await createChat(event.chatModel);
      yield* result.fold((failure) async* {
        yield CreateChatErrorState();
      }, (bool state) async* {
        yield CreateChatState();
      });
    }
    if (event is InitBlocEvent) {
      yield GetChatGroupStreamLoadingState();
      yield ChatGroupInitial();
    }
  }
}
