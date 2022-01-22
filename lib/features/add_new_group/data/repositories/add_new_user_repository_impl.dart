import 'package:almanubis/core/errors/exceptions.dart';
import 'package:almanubis/core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/add_new_group/data/data_sources/add_new_user_data_source.dart';
import 'package:almanubis/features/add_new_group/domain/repositories/add_new_user_repository.dart';
import 'package:dartz/dartz.dart';

class AddNewUserRepositoryImpl implements AddNewUserRepository {
  final AddNewUserDataSource addNewUserDataSource;

  AddNewUserRepositoryImpl({required this.addNewUserDataSource});

  @override
  Future<Either<Failure, List<UserModel>>> getAllUser() async {
    try {
      final response = await addNewUserDataSource.getAllUser();
      return Right(response);
    } on GetAllUserException {
      return Left(RegisterUserDbFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> searchUser(String text) async {
    try {
      final response = await addNewUserDataSource.searchUser(text);
      return Right(response);
    } on GetAllUserException {
      return Left(RegisterUserDbFailure());
    }
  }
}
