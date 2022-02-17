import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/new_user/domain/use_cases/register_email.dart';
import 'package:almanubis/features/new_user/domain/use_cases/register_user_db.dart';

part 'new_user_event.dart';

part 'new_user_state.dart';

class NewUserBloc extends Bloc<NewUserEvent, NewUserState> {
  final RegisterEmail registerEmail;
  final RegisterUserDb registerUserDb;

  NewUserBloc({
    required this.registerEmail,
    required this.registerUserDb,
  }) : super(NewUserInitial());

  @override
  Stream<NewUserState> mapEventToState(
    NewUserEvent event,
  ) async* {
    if (event is RegisterEmailEvent) {
      yield NewUserRegisterLoading();
      final result = await registerEmail(
        RegisterEmailParams(
          password: event.password,
          email: event.userModel.email,
        ),
      );
      yield* result.fold((failure) async* {
        yield NewUserRegisterFailure();
      }, (User success) async* {
        event.userModel.uid = success.uid;
        final resultDb = await registerUserDb(event.userModel);
        yield* resultDb.fold((failure) async* {
          yield RegisterUserDbFailure();
        }, (success) async* {
          yield RegisterUserDbLoaded(userModel: success);
        });
      });
    }
    if (event is ChangePasswordEvent) {
      yield RegisterUserDbLoading();
      yield ChangePasswordState(event.state);
    }
    if (event is ChangeRepeatPasswordEvent) {
      yield RegisterUserDbLoading();
      yield ChangeRepeatPasswordState(event.state);
    }
  }
}
