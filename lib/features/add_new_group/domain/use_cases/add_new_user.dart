import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/add_new_group/domain/repositories/add_new_user_repository.dart';

class AddNewUserUseCase extends UseCase<bool, AddNewUserParams> {
  final AddNewUserRepository addNewUserRepository;

  AddNewUserUseCase({required this.addNewUserRepository});

  @override
  Future<Either<Failure, bool>> call(AddNewUserParams params) {
    return addNewUserRepository.addNewUser(user: params.user, idGroup: params.idGroup);
  }
}

class AddNewUserParams {
  List<UserModel> user;
  String idGroup;

  AddNewUserParams({required this.idGroup, required this.user});
}
