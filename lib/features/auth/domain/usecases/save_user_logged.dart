import 'package:almanubis/core/errors/failure.dart';
import 'package:almanubis/features/auth/data/models/credentials_model.dart';
import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/usecases/use_cases.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

class SaveUserLogged extends UseCase<bool, CredentialsModel> {
  final AuthRepository authRepository;

  SaveUserLogged({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(CredentialsModel credentialsModel) {
    return authRepository.saveUserLogged(credentialsModel);
  }
}
