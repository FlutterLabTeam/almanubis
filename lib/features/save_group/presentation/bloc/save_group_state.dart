part of 'save_group_bloc.dart';

abstract class SaveGroupState {}

class SaveGroupInitial extends SaveGroupState {}

class ChangeStateLoading extends SaveGroupState {}

class ChangeStateState extends SaveGroupState {
  final UserModel userModel;

  ChangeStateState(this.userModel);
}

class SaveNewGroupState extends SaveGroupState {}

class SaveNewGroupErrorState extends SaveGroupState {}

class SaveNewGroupLoadingState extends SaveGroupState {}
