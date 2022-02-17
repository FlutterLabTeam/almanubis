import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/new_group/domain/repositories/new_group_repository.dart';

class SearchUser extends UseCase<List<UserModel>, String> {
  final NewGroupRepository newGroupRepository;

  SearchUser({required this.newGroupRepository});

  @override
  Future<Either<Failure, List<UserModel>>> call(String params) {
    return newGroupRepository.searchUser(params);
  }
}