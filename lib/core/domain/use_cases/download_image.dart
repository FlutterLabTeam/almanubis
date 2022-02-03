import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class DownloadImage extends UseCase<bool, DownloadImageParams> {
  final GlobalRepository globalRepository;

  DownloadImage({required this.globalRepository});

  @override
  Future<Either<Failure, bool>> call(DownloadImageParams params) {
    return globalRepository.downloadImage(
      path: params.path,
      folderDB: params.folderDB
    );
  }
}

class DownloadImageParams {
  String folderDB;
  String path;

  DownloadImageParams({
    required this.path,
    required this.folderDB,
  });
}