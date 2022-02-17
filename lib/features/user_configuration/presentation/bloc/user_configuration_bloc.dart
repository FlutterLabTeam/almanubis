import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/user_configuration/domain/use_cases/update_user.dart';

part 'user_configuration_event.dart';

part 'user_configuration_state.dart';

class UserConfigurationBloc extends Bloc<UserConfigurationEvent, UserConfigurationState> {
  final UpdateUser updateUser;

  UserConfigurationBloc({
    required this.updateUser,
  }) : super(UserConfigurationInitial());

  @override
  Stream<UserConfigurationState> mapEventToState(
    UserConfigurationEvent event,
  ) async* {
    if (event is UpdateUserEvent) {
      yield UpdateUserLoadingState();
      final result = await updateUser(event.userModel);
       yield* result.fold((failure) async* {
        yield UpdateUserErrorState();
      }, (bool listUser) async* {
        yield UpdateUserState();
      });
    }
  }
}
