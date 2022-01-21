part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoadingEvent implements AuthEvent {}

class LoginEvent implements AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class ChangePasswordEvent implements AuthEvent {
  final bool state;

  ChangePasswordEvent({required this.state});
}

class ValidateUserLoggedEvent extends AuthEvent {}

class SetDataUserEvent extends AuthEvent {
  final UserModel userModel;

  SetDataUserEvent({required this.userModel});
}
