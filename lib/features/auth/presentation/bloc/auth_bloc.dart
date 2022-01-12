import 'dart:async';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/auth/domain/usecases/get_user_data.dart';
import 'package:almanubis/features/auth/domain/usecases/login_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserData getUserData;
  final LoginEmail loginEmail;

  AuthBloc({
    required this.loginEmail,
    required this.getUserData,
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
  }
}
