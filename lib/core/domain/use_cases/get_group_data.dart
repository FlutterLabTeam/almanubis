import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class GetGroupData extends UseCase<GroupModel, String> {
  final GlobalRepository globalRepository;

  GetGroupData({required this.globalRepository});

  @override
  Future<Either<Failure, GroupModel>> call(String params) {
    return globalRepository.getGroupData(idGroup: params);
  }
}
