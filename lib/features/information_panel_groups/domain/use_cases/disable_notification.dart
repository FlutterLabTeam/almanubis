import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/information_panel_groups/domain/repositories/information_panel_repository.dart';

class DisableNotification extends UseCase<bool, DisableNotificationParams> {
  final InformationPanelRepository informationPanelRepository;

  DisableNotification({required this.informationPanelRepository});

  @override
  Future<Either<Failure, bool>> call(DisableNotificationParams params) {
    return informationPanelRepository.disableNotification(
      idGroup: params.idGroup,
      idUser: params.idUser,
    );
  }
}

class DisableNotificationParams {
  final String idGroup;
  final String idUser;

  DisableNotificationParams({
    required this.idUser,
    required this.idGroup,
  });
}
