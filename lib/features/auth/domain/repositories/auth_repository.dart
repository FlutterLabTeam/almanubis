import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:almanubis/core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> validateCode(String validationId, String smsCode);
}
