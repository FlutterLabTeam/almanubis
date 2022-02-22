part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ChangeViewEvent implements HomeEvent {

  final int page;

  ChangeViewEvent({required this.page});
}
