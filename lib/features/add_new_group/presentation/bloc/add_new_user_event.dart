part of 'add_new_user_bloc.dart';

@immutable
abstract class AddNewUserEvent {}

class ChangeStateEvent implements AddNewUserEvent {
  final UserModel userModel;

  ChangeStateEvent({required this.userModel});
}

class GetAllUserEvent implements AddNewUserEvent {}

class AddNewUserInitEvent implements AddNewUserEvent {}

class SearchUserEvent implements AddNewUserEvent {
  final String userText;
  final List<UserModel> listStaticUserModel;

  SearchUserEvent({
    required this.userText,
    required this.listStaticUserModel,
  });
}

class AddNewUserDataEvent implements AddNewUserEvent {
  final String idGroup;
  final List<UserModel> userModel;

  AddNewUserDataEvent({
    required this.idGroup,
    required this.userModel,
  });
}


