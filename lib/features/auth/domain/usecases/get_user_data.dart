import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/model/user_model.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class GetUserData extends UseCase<UserModel, String> {
  final AuthRepository authRepository;

  GetUserData({required this.authRepository});

  @override
  Future<Either<Failure, UserModel>> call(String params) {
    return authRepository.getUserDb(params);
  }
}
