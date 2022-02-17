import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/add_new_group/domain/repositories/add_new_user_repository.dart';

class SearchUserAdd extends UseCase<List<UserModel>, String> {
  final AddNewUserRepository addNewUserRepository;

  SearchUserAdd({required this.addNewUserRepository});

  @override
  Future<Either<Failure, List<UserModel>>> call(String params) {
    return addNewUserRepository.searchUser(params);
  }
}