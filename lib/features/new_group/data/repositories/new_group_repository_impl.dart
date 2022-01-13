import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/new_group/data/data_sources/new_group_data_source.dart';
import 'package:almanubis/features/new_group/domain/repositories/new_group_repository.dart';

class NewGroupRepositoryImpl implements NewGroupRepository {
  final NewGroupDataSource newGroupDataSource;

  NewGroupRepositoryImpl({required this.newGroupDataSource});

  @override
  Future<Either<Failure, List<UserModel>>> getAllUser() async {
    try {
      final response = await newGroupDataSource.getAllUser();
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterUserDbFailure());
    }
  }
}
