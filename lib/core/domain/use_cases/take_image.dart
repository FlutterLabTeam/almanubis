import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class TakeImage extends UseCase<String, ImageQualityModel> {
  final GlobalRepository globalRepository;

  TakeImage({required this.globalRepository});

  @override
  Future<Either<Failure, String>> call(ImageQualityModel params) {
    return globalRepository.takeImage(imageQualityModel: params);
  }
}
