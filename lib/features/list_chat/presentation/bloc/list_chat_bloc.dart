import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/list_chat/domain/use_cases/get_list_chat_data.dart';

part 'list_chat_event.dart';

part 'list_chat_state.dart';

class ListChatBloc extends Bloc<ListChatEvent, ListChatState> {
  final GetListChat getListChat;

  ListChatBloc({
    required this.getListChat,
  }) : super(ListChatInitial());

  @override
  Stream<ListChatState> mapEventToState(
    ListChatEvent event,
  ) async* {
    if (event is GetAllListChat) {
      yield GetAllListChatLoadingState();
      final result = await getListChat(NoParams());
      yield* result.fold((failure) async* {
        yield GetAllListChatErrorState();
      }, (List<GroupModel> listChat) async* {
        yield GetAllListChatState(listChatModel: listChat);
      });
    }
  }
}
