import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/user_configuration/data/data_sources/user_configuration_data_source.dart';
import 'package:almanubis/features/user_configuration/domain/repositories/user_configuration_repository.dart';

class UserConfigurationRepositoryImpl implements UserConfigurationRepository {
  final UserConfigurationDataSource userConfigurationDataSource;

  UserConfigurationRepositoryImpl({required this.userConfigurationDataSource});

  @override
  Future<Either<Failure, bool>> updateUser(UserModel userModel) async {
    try {
      final response = await userConfigurationDataSource.updateUser(userModel);
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }
}
