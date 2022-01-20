part of 'information_panel_bloc.dart';

abstract class InformationPanelState {}

class InformationPanelInitial extends InformationPanelState {}

class ActiveNotificationState extends InformationPanelState {}

class ActiveNotificationErrorState extends InformationPanelState {}

class ActiveNotificationLoadingState extends InformationPanelState {}

class DisableNotificationState extends InformationPanelState {}

class DisableNotificationErrorState extends InformationPanelState {}

class DisableNotificationLoadingState extends InformationPanelState {}

class DeleteUserState extends InformationPanelState {

  final UserModel userModel;

  DeleteUserState({required this.userModel});

}

class DeleteUserErrorState extends InformationPanelState {}

class DeleteUserLoadingState extends InformationPanelState {}
