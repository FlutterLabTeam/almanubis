part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginErrorState extends AuthState {}

class GetUserDataErrorState extends AuthState {}

class GetUserDataLoadedState extends AuthState {

  final UserModel userModel;

  GetUserDataLoadedState({required this.userModel});
}

class ChangePasswordState implements AuthState {
  final bool state;

  ChangePasswordState({required this.state});
}

class NoExistCredentialErrorState extends AuthState {}

class ExistCredentialState extends AuthState {

  final CredentialsModel dataCredential;

  ExistCredentialState({required this.dataCredential});
}