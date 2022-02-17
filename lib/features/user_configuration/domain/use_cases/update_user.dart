import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/user_configuration/domain/repositories/user_configuration_repository.dart';

class UpdateUser extends UseCase<bool, UserModel> {
  final UserConfigurationRepository userConfigurationRepository;

  UpdateUser({required this.userConfigurationRepository});

  @override
  Future<Either<Failure, bool>> call(params) {
    return userConfigurationRepository.updateUser(params);
  }
}
