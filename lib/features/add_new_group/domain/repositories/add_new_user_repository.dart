import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';

abstract class AddNewUserRepository {
  Future<Either<Failure, List<UserModel>>> getAllUser();
  Future<Either<Failure, List<UserModel>>> searchUser(String text);
  Future<Either<Failure, bool>> addNewUser({required List<UserModel> user, required String idGroup,});
}
