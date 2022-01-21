import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class GlobalRepository {
  Future<Either<Failure, String>> takePhoto();
  Future<Either<Failure, String>> saveImage({required String path, String? idUser, required String folderDB,});
  Future<Either<Failure, String>> updateImage({required String path, required String linkImage, required String? idUser, required String folderDB,});
}
