import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:almanubis/core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/auth/data/models/credentials_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> getUserDb(String uid);
  Future<Either<Failure, CredentialsModel>> validateUserLogged();
  Future<Either<Failure, bool>> setDataUSer(UserModel userModel);
  Future<Either<Failure, User>> loginEmail(String email, String password);
  Future<Either<Failure, bool>> saveUserLogged(CredentialsModel credentialsModel);
}
