import 'package:almanubis/core/model/user_model.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserConfigurationRepository {
  Future<Either<Failure, bool>> updateUser(UserModel userModel);
}
