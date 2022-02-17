part of 'user_configuration_bloc.dart';

@immutable
abstract class UserConfigurationEvent {}

class UpdateUserEvent  implements UserConfigurationEvent {

  final UserModel userModel;

  UpdateUserEvent({required this.userModel});
}
