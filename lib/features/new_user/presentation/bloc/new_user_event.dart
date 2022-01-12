part of 'new_user_bloc.dart';

@immutable
abstract class NewUserEvent {}

class RegisterEmailEvent implements NewUserEvent {
  final UserModel userModel;
  final String password;

  RegisterEmailEvent({required this.userModel, required this.password});
}

class RegisterUserDbEvent implements NewUserEvent {
  final UserModel userModel;

  RegisterUserDbEvent({required this.userModel});
}

class ChangePasswordEvent  implements NewUserEvent {
  final bool state;

  ChangePasswordEvent({required this.state});
}

class ChangeRepeatPasswordEvent  implements NewUserEvent {
  final bool state;

  ChangeRepeatPasswordEvent({required this.state});
}
