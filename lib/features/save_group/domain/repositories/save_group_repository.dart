import 'package:almanubis/core/model/group_model.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SaveGroupRepository {
  Future<Either<Failure, bool>> saveNewGroup(GroupModel groupModel);
}
