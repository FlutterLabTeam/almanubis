import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/get_user_data.dart';
import '../../domain/usecases/login_email.dart';
import '../../domain/usecases/save_user_logged.dart';
import '../../domain/usecases/set_data_user.dart';
import '../../domain/usecases/validate_user_logged.dart';
import 'auth_screen_state.dart';

class AuthCubit extends Cubit<AuthScreenState> {
  final LoginEmail _loginEmail;
  final GetUserData _getUserData;
  final SetDataUSer _setDataUSer;
  final SaveUserLogged _saveUserLogged;
  final ValidateUserLogged _validateUserLogged;

  AuthCubit(
    AuthState initialState,
    LoginEmail loginEmail,
    GetUserData getUserData,
    SetDataUSer setDataUSer,
    SaveUserLogged saveUserLogged,
    ValidateUserLogged validateUserLogged,
  )   : _loginEmail = loginEmail,
        _getUserData = getUserData,
        _setDataUSer = setDataUSer,
        _saveUserLogged = saveUserLogged,
        _validateUserLogged = validateUserLogged,
        super(AuthScreenState.initial());

  Future<void> load() async {
    emit(
      AuthScreenState.initial(),
    );
  }

  Future<void> login(String email, String password) async {
    final result = await _loginEmail(
      LoginEmailParams(email: email, password: password),
    );

    state.copyWith(
      isLoginSuccess: (result is User),
    );
  }
}
