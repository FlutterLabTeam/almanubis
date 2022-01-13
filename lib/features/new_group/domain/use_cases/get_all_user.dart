import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/new_group/domain/repositories/new_group_repository.dart';

class GetAllUser extends UseCase<List<UserModel>, NoParams> {
  final NewGroupRepository newGroupRepository;

  GetAllUser({required this.newGroupRepository});

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) {
    return newGroupRepository.getAllUser();
  }
}