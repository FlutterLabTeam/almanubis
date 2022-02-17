import 'dart:async';
import 'package:almanubis/features/information_panel_groups/domain/use_cases/active_notification.dart';
import 'package:almanubis/features/information_panel_groups/domain/use_cases/delete_user.dart';
import 'package:almanubis/features/information_panel_groups/domain/use_cases/disable_notification.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';

part 'information_panel_event.dart';

part 'information_panel_state.dart';

class InformationPanelBloc
    extends Bloc<InformationPanelEvent, InformationPanelState> {
  final DeleteUser deleteUser;
  final ActiveNotification activeNotification;
  final DisableNotification disableNotification;

  InformationPanelBloc({
    required this.deleteUser,
    required this.activeNotification,
    required this.disableNotification,
  }) : super(InformationPanelInitial());

  @override
  Stream<InformationPanelState> mapEventToState(
    InformationPanelEvent event,
  ) async* {
    if (event is ActiveNotificationEvent) {
      yield ActiveNotificationLoadingState();
      final result = await activeNotification(
        ActiveNotificationParams(
          idUser: event.idUser,
          idGroup: event.idGroup,
        ),
      );
      yield* result.fold((failure) async* {
        yield ActiveNotificationErrorState();
      }, (bool listUser) async* {
        yield ActiveNotificationState();
      });
    }
    if (event is DisableNotificationEvent) {
      yield DisableNotificationLoadingState();
      final result = await disableNotification(
        DisableNotificationParams(
          idUser: event.idUser,
          idGroup: event.idGroup,
        ),
      );
      yield* result.fold((failure) async* {
        yield DisableNotificationErrorState();
      }, (bool listUser) async* {
        yield DisableNotificationState();
      });
    }
    if (event is DeleteUserEvent) {
      yield DeleteUserLoadingState();
      final result = await deleteUser(
        DeleteUserParams(
          user: event.user,
          idGroup: event.idGroup,
        ),
      );
      yield* result.fold((failure) async* {
        yield DeleteUserErrorState();
      }, (UserModel user) async* {
        yield DeleteUserState(userModel: user);
      });
    }
  }
}
