import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/core/data/data_sources/global_data_source.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class GlobalRepositoryImpl implements GlobalRepository {
  final GlobalDataSource globalDataSource;

  GlobalRepositoryImpl({required this.globalDataSource});

  @override
  Future<Either<Failure, String>> takePhoto() async {
    try {
      final response = await globalDataSource.takePhoto();
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveImage({
    String? idUser,
    required String path,
    required String folderDB,
  }) async {
    try {
      final response = await globalDataSource.saveImage(
        path: path,
        idUser: idUser,
        folderDB: folderDB,
      );
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateImage({
    required String path,
    required String linkImage,
    required String? idUser,
    required String folderDB,
  }) async {
    try {
      final response = await globalDataSource.updateImage(
        path: path,
        linkImage: linkImage,
        idUser: idUser,
        folderDB: folderDB,
      );
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }
}
