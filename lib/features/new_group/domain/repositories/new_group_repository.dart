import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';

abstract class NewGroupRepository {
  Future<Either<Failure, List<UserModel>>> getAllUser();
  Future<Either<Failure, List<UserModel>>> searchUser(String text);
}
