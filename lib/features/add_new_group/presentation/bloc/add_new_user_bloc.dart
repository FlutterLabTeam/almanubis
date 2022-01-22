import 'dart:async';
import 'package:almanubis/features/add_new_group/domain/use_cases/get_all_user.dart';
import 'package:almanubis/features/add_new_group/domain/use_cases/search_user.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';

part 'add_new_user_event.dart';

part 'add_new_user_state.dart';

class AddNewUserBloc extends Bloc<AddNewUserEvent, AddNewUserState> {
  final GetAllUserAdd getAllUserAdd;
  final SearchUserAdd searchUserAdd;

  AddNewUserBloc({
    required this.getAllUserAdd,
    required this.searchUserAdd,
  }) : super(AddNewUserInitial());

  @override
  Stream<AddNewUserState> mapEventToState(
    AddNewUserEvent event,
  ) async* {
    if (event is ChangeStateEvent) {
      yield ChangeStateLoading();
      yield ChangeStateState(event.userModel);
    }
    if (event is AddNewUserInitEvent) {
      yield ChangeStateLoading();
      yield AddNewUserInitial();
    }
    if (event is GetAllUserEvent) {
      yield ChangeStateLoading();
      final result = await getAllUserAdd(NoParams());
      yield* result.fold((failure) async* {
        yield GetAllUserErrorState();
      }, (List<UserModel> listUser) async* {
        yield GetAllUserState(listUser);
      });
    }
    if (event is SearchUserEvent) {
        yield ChangeStateLoading();
      if (event.userText.isNotEmpty) {
        final result = await searchUserAdd(event.userText);
        yield* result.fold((failure) async* {
          yield GetAllUserErrorState();
        }, (List<UserModel> listUser) async* {
          yield GetSearchUserState(listUser);
        });
      } else {
        yield GetSearchUserState(event.listStaticUserModel);
      }
    }
  }
}
