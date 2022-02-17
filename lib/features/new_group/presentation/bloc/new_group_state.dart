part of 'new_group_bloc.dart';

abstract class NewGroupState {}

class NewGroupInitial extends NewGroupState {}

class ChangeStateLoading extends NewGroupState {}
class GetAllUserFinalStare extends NewGroupState {}

class ChangeStateState extends NewGroupState {
  final UserModel userModel;

  ChangeStateState(this.userModel);
}

class GetAllUserState extends NewGroupState {
  final List<UserModel> listUserModel;

  GetAllUserState(this.listUserModel);
}

class GetSearchUserState extends NewGroupState {
  final List<UserModel> listUserModel;

  GetSearchUserState(this.listUserModel);
}

class GetAllUserErrorState extends NewGroupState {}
