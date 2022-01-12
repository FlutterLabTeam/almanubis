part of 'new_user_bloc.dart';

abstract class NewUserState {}

class RegisterUserDbLoading extends NewUserState {}

class NewUserRegisterLoading extends NewUserState {}

class NewUserRegisterFailure extends NewUserState {}

class RegisterUserDbLoaded extends NewUserState {
  final UserModel userModel;

  RegisterUserDbLoaded({required this.userModel});
}

class RegisterUserDbFailure extends NewUserState {}

class NewUserInitial extends NewUserState {}

class ChangePasswordState extends NewUserState {
  final bool state;

  ChangePasswordState(this.state);
}

class ChangeRepeatPasswordState extends NewUserState {
  final bool state;

  ChangeRepeatPasswordState(this.state);
}
