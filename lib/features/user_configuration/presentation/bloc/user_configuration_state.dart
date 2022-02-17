part of 'user_configuration_bloc.dart';

abstract class UserConfigurationState {}

class UserConfigurationInitial extends UserConfigurationState {}

class UpdateUserState extends UserConfigurationState {}

class UpdateUserErrorState extends UserConfigurationState {}

class UpdateUserLoadingState extends UserConfigurationState {}
