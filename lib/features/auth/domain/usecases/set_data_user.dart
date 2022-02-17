import 'package:almanubis/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/use_cases.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';

class SetDataUSer extends UseCase<bool, UserModel> {
  final AuthRepository authRepository;

  SetDataUSer({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(UserModel userModel) {
    return authRepository.setDataUSer(userModel);
  }
}
