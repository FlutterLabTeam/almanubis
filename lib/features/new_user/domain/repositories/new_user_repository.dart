import 'package:almanubis/core/model/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class NewUserRepository {
  Future<Either<Failure, User>> registerEmail(String email, String password);

  Future<Either<Failure, UserModel>> registerUserDb(UserModel userModel);
}
