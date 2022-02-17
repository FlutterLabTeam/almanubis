import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/features/save_group/domain/use_cases/save_new_group.dart';

part 'save_group_event.dart';

part 'save_group_state.dart';

class SaveGroupBloc extends Bloc<SaveGroupEvent, SaveGroupState> {
  final SaveNewGroup saveNewGroup;

  SaveGroupBloc({
    required this.saveNewGroup,
  }) : super(SaveGroupInitial());

  @override
  Stream<SaveGroupState> mapEventToState(
    SaveGroupEvent event,
  ) async* {
    if (event is ChangeStateEvent) {
      yield ChangeStateLoading();
      yield ChangeStateState(event.userModel);
    }
    if (event is SaveNewGroupEvent) {
      yield SaveNewGroupLoadingState();
      final result = await saveNewGroup(event.groupModel);
       yield* result.fold((failure) async* {
        yield SaveNewGroupErrorState();
      }, (GroupModel groupModel) async* {
        yield SaveNewGroupState(
          groupModel: groupModel
        );
      });
    }
  }
}
