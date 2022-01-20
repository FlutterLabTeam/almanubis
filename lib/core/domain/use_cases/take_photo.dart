import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class TakePhoto extends UseCase<String, NoParams> {
  final GlobalRepository globalRepository;

  TakePhoto({required this.globalRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return globalRepository.takePhoto();
  }
}
