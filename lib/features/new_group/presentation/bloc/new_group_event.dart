part of 'new_group_bloc.dart';

@immutable
abstract class NewGroupEvent {}

class ChangeStateEvent  implements NewGroupEvent {
  final UserModel userModel;

  ChangeStateEvent({required this.userModel});
}

class GetAllUserEvent  implements NewGroupEvent {}
