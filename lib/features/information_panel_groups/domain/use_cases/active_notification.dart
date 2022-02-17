import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/information_panel_groups/domain/repositories/information_panel_repository.dart';

class ActiveNotification extends UseCase<bool, ActiveNotificationParams> {
  final InformationPanelRepository informationPanelRepository;

  ActiveNotification({required this.informationPanelRepository});

  @override
  Future<Either<Failure, bool>> call(ActiveNotificationParams params) {
    return informationPanelRepository.activeNotification(
      idGroup: params.idGroup,
      idUser: params.idUser,
    );
  }
}

class ActiveNotificationParams {
  final String idGroup;
  final String idUser;

  ActiveNotificationParams({
    required this.idUser,
    required this.idGroup,
  });
}
