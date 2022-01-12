import 'dart:async';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/auth/data/models/credentials_model.dart';
import 'package:almanubis/features/auth/domain/usecases/get_user_data.dart';
import 'package:almanubis/features/auth/domain/usecases/login_email.dart';
import 'package:almanubis/features/auth/domain/usecases/validate_user_logged.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserData getUserData;
  final LoginEmail loginEmail;
  final ValidateUserLogged validateUserLogged;

  AuthBloc({
    required this.loginEmail,
    required this.getUserData,
    required this.validateUserLogged,
  }) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoadingEvent) {
      yield AuthInitial();
    }
    if (event is LoginEvent) {
      yield LoginLoadingState();
      final result = await loginEmail(
        LoginEmailParams(
          email: event.email,
          password: event.password,
        ),
      );
      yield* result.fold((failure) async* {
        yield LoginErrorState();
      }, (User user) async* {
        final resultDb = await getUserData(user.uid);
        yield* resultDb.fold((failure) async* {
          yield GetUserDataErrorState();
        }, (success) async* {
          yield GetUserDataLoadedState(userModel: success);
        });
      });
    }
    if (event is ChangePasswordEvent) {
      yield LoginLoadingState();
      yield ChangePasswordState(state: event.state);
    }
    if (event is ValidateUserLoggedEvent) {
      final dataCredential = await validateUserLogged(NoParams());
      yield* dataCredential.fold((error) async* {
        yield NoExistCredentialErrorState();
      }, (credential) async* {
        if (credential.email.isEmpty) {
          yield NoExistCredentialErrorState();
        } else {
          yield ExistCredentialState(dataCredential: credential);
        }
      });
    }
  }
}
