import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ListChatRepository {
  Future<Either<Failure, List<GroupModel>>> getListChat();
}
