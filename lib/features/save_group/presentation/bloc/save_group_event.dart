part of 'save_group_bloc.dart';

@immutable
abstract class SaveGroupEvent {}

class ChangeStateEvent  implements SaveGroupEvent {
  final UserModel userModel;

  ChangeStateEvent({required this.userModel});
}

class GetAllUserEvent  implements SaveGroupEvent {}
class InitStateSaveGroupEvent  implements SaveGroupEvent {}

class SaveNewGroupEvent  implements SaveGroupEvent {

  final GroupModel groupModel;

  SaveNewGroupEvent({required this.groupModel});
}
