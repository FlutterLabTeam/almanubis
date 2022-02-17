import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class LoginEmail extends UseCase<User, LoginEmailParams> {
  final AuthRepository authRepository;

  LoginEmail({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(params) {
    return authRepository.loginEmail(params.email, params.password);
  }
}

class LoginEmailParams {
  final String email;
  final String password;

  LoginEmailParams({required this.email, required this.password});
}
