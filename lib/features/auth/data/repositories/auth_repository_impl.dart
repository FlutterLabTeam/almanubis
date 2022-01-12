import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/auth/data/datasources/auth_data_source.dart';
import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, UserModel>> getUserDb(String uid) async {
    try {
      final response = await authDataSource.getUserDb(uid);
      return Right(response);
    } on GetUserDbException {
      return Left(GetUserDbFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginEmail(String email, String password) async {
    try {
      final response = await authDataSource.loginEmail(email, password);
      return Right(response);
    } on LoginEmailException {
      return Left(LoginEmailFailure());
    }
  }
}
