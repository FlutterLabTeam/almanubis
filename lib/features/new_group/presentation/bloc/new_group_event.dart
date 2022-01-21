part of 'new_group_bloc.dart';

@immutable
abstract class NewGroupEvent {}

class ChangeStateEvent implements NewGroupEvent {
  final UserModel userModel;

  ChangeStateEvent({required this.userModel});
}

class GetAllUserEvent implements NewGroupEvent {}

class NewGroupInitEvent implements NewGroupEvent {}

class SearchUserEvent implements NewGroupEvent {
  final String userText;
  final List<UserModel> listStaticUserModel;

  SearchUserEvent({
    required this.userText,
    required this.listStaticUserModel,
  });
}


