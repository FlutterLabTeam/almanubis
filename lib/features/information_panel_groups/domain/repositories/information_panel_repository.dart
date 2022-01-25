import 'package:almanubis/core/model/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class InformationPanelRepository {
  Future<Either<Failure, bool>> activeNotification({
    required String idGroup,
    required String idUser,
  });

  Future<Either<Failure, bool>> disableNotification({
    required String idGroup,
    required String idUser,
  });

  Future<Either<Failure, UserModel>> deleteUser({
    required String idGroup,
    required UserModel user,
  });
}
