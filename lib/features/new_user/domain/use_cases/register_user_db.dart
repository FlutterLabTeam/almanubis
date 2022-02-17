import 'package:almanubis/core/model/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import 'package:almanubis/features/new_user/domain/repositories/new_user_repository.dart';

class RegisterUserDb extends UseCase<UserModel, UserModel> {
  final NewUserRepository newUserRepository;

  RegisterUserDb({required this.newUserRepository});

  @override
  Future<Either<Failure, UserModel>> call(params) {
    return newUserRepository.registerUserDb(params);
  }
}
