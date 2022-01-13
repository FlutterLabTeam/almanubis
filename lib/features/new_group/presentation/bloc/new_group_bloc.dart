import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/new_group/domain/use_cases/get_all_user.dart';

part 'new_group_event.dart';

part 'new_group_state.dart';

class NewGroupBloc extends Bloc<NewGroupEvent, NewGroupState> {
  final GetAllUser getAllUser;

  NewGroupBloc({
    required this.getAllUser,
  }) : super(NewGroupInitial());

  @override
  Stream<NewGroupState> mapEventToState(
    NewGroupEvent event,
  ) async* {
    if (event is ChangeStateEvent) {
      yield ChangeStateLoading();
      yield ChangeStateState(event.userModel);
    }
    if (event is GetAllUserEvent) {
      yield ChangeStateLoading();
      final result = await getAllUser(NoParams());
      yield* result.fold((failure) async* {
        yield GetAllUserErrorState();
      }, (List<UserModel> listUser) async* {
        yield GetAllUserState(listUser);
      });
    }
  }
}
