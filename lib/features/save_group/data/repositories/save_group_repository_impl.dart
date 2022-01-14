import 'package:almanubis/features/save_group/domain/repositories/save_group_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/features/save_group/data/data_sources/save_group_data_source.dart';

class SaveGroupRepositoryImpl implements SaveGroupRepository {
  final SaveGroupDataSource saveGroupDataSource;

  SaveGroupRepositoryImpl({required this.saveGroupDataSource});

  @override
  Future<Either<Failure, bool>> saveNewGroup(GroupModel groupModel) async {
    try {
      final response = await saveGroupDataSource.saveNewGroup(groupModel);
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }
}
