import 'package:almanubis/core/data/model/image_quality_model.dart';

import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class GlobalRepository {
  Future<Either<Failure, String>> takeVideo();
  Future<Either<Failure, String>> takePhoto({required ImageQualityModel imageQualityModel});
  Future<Either<Failure, String>> takeImage({required ImageQualityModel imageQualityModel});
  Future<Either<Failure, bool>> downloadAssets({required String folderDB,required String path});
  Future<Either<Failure, String>> saveImage({required String path, String? idUser, required String folderDB,});
  Future<Either<Failure, String>> updateImage({required String path, required String linkImage, required String? idUser, required String folderDB,});
}
