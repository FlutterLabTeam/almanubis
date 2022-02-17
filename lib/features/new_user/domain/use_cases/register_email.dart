import 'package:almanubis/features/new_user/domain/repositories/new_user_repository.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class RegisterEmail extends UseCase<User, RegisterEmailParams> {
  final NewUserRepository newUserRepository;

  RegisterEmail({required this.newUserRepository});

  @override
  Future<Either<Failure, User>> call(params) {
    return newUserRepository.registerEmail(params.email, params.password);
  }
}

class RegisterEmailParams {
  final String email;
  final String password;

  RegisterEmailParams({required this.email, required this.password});
}
