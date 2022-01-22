part of 'add_new_user_bloc.dart';

abstract class AddNewUserState {}

class AddNewUserInitial extends AddNewUserState {}

class ChangeStateLoading extends AddNewUserState {}
class GetAllUserFinalStare extends AddNewUserState {}

class ChangeStateState extends AddNewUserState {
  final UserModel userModel;

  ChangeStateState(this.userModel);
}

class GetAllUserState extends AddNewUserState {
  final List<UserModel> listUserModel;

  GetAllUserState(this.listUserModel);
}

class GetSearchUserState extends AddNewUserState {
  final List<UserModel> listUserModel;

  GetSearchUserState(this.listUserModel);
}

class GetAllUserErrorState extends AddNewUserState {}
