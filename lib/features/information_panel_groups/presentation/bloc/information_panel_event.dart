part of 'information_panel_bloc.dart';

@immutable
abstract class InformationPanelEvent {}

class ActiveNotificationEvent implements InformationPanelEvent {
  final String idGroup;
  final String idUser;

  ActiveNotificationEvent({required this.idUser, required this.idGroup});
}

class DisableNotificationEvent implements InformationPanelEvent {
  final String idGroup;
  final String idUser;

  DisableNotificationEvent({required this.idUser, required this.idGroup});
}
class DeleteUserEvent implements InformationPanelEvent {
  final String idGroup;
  final UserModel user;

  DeleteUserEvent({required this.user, required this.idGroup});
}
