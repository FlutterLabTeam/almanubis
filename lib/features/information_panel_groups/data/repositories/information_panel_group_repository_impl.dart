import 'package:almanubis/core/model/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/features/information_panel_groups/data/data_sources/information_panel_data_source.dart';
import 'package:almanubis/features/information_panel_groups/domain/repositories/information_panel_repository.dart';

class InformationPanelRepositoryImpl implements InformationPanelRepository {
  final InformationPanelDataSource informationPanelDataSource;

  InformationPanelRepositoryImpl({required this.informationPanelDataSource});

  @override
  Future<Either<Failure, bool>> activeNotification({
    required String idGroup,
    required String idUser,
  }) async {
    try {
      final response = await informationPanelDataSource.activeNotification(
        idGroup: idGroup,
        idUser: idUser,
      );
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterUserDbFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> disableNotification({
    required String idGroup,
    required String idUser,
  }) async {
    try {
      final response = await informationPanelDataSource.disableNotification(
        idGroup: idGroup,
        idUser: idUser,
      );
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterUserDbFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> deleteUser({
    required String idGroup,
    required UserModel user,
  }) async {
    try {
      final response = await informationPanelDataSource.deleteUser(
        idGroup: idGroup,
        user: user,
      );
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterUserDbFailure());
    }
  }
}
