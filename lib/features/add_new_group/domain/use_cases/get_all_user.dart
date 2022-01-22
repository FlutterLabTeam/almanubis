import 'package:almanubis/features/add_new_group/domain/repositories/add_new_user_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';

class GetAllUserAdd extends UseCase<List<UserModel>, NoParams> {
  final AddNewUserRepository addNewUserRepository;

  GetAllUserAdd({required this.addNewUserRepository});

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) {
    return addNewUserRepository.getAllUser();
  }
}