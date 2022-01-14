import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/save_group/domain/repositories/save_group_repository.dart';

class SaveNewGroup extends UseCase<bool, GroupModel> {
  final SaveGroupRepository saveGroupRepository;

  SaveNewGroup({required this.saveGroupRepository});

  @override
  Future<Either<Failure, bool>> call(params) {
    return saveGroupRepository.saveNewGroup(params);
  }
}
