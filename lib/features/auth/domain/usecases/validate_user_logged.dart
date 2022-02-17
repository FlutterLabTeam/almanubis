import 'package:dartz/dartz.dart';
import 'package:almanubis/core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/auth/data/models/credentials_model.dart';
import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';

class ValidateUserLogged extends UseCase<CredentialsModel, NoParams> {
  final AuthRepository authRepository;

  ValidateUserLogged({required this.authRepository});

  @override
  Future<Either<Failure, CredentialsModel>> call(NoParams params) {
    return authRepository.validateUserLogged();
  }
}
