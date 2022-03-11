part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeViewState extends HomeState {

  final int page;

  ChangeViewState({required this.page});
}
