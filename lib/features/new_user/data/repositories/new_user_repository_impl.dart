import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/new_user/data/data_sources/new_user_data_source.dart';
import 'package:almanubis/features/new_user/domain/repositories/new_user_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewUserRepositoryImpl implements NewUserRepository {
  final NewUserDataSource newUserDataSource;

  NewUserRepositoryImpl({required this.newUserDataSource});

  @override
  Future<Either<Failure, User>> registerEmail(
      String email, String password) async {
    try {
      final response = await newUserDataSource.registerEmail(email, password);
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerUserDb(UserModel userModel) async {
    try {
      final response = await newUserDataSource.registerDb(userModel);
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterUserDbFailure());
    }
  }
}
