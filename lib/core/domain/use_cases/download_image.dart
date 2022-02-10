import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class DownloadAssets extends UseCase<bool, DownloadAssetsParams> {
  final GlobalRepository globalRepository;

  DownloadAssets({required this.globalRepository});

  @override
  Future<Either<Failure, bool>> call(DownloadAssetsParams params) {
    return globalRepository.downloadAssets(
      path: params.path,
      folderDB: params.folderDB
    );
  }
}

class DownloadAssetsParams {
  String folderDB;
  String path;

  DownloadAssetsParams({
    required this.path,
    required this.folderDB,
  });
}