import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class UpdateImage extends UseCase<String, UpdateImageParams> {
  final GlobalRepository globalRepository;

  UpdateImage({required this.globalRepository});

  @override
  Future<Either<Failure, String>> call(UpdateImageParams params) {
    return globalRepository.updateImage(
      path: params.path,
      idUser: params.idUser,
      folderDB: params.folderDB,
      linkImage: params.linkImage,
    );
  }
}

class UpdateImageParams {
  String path;
  String? idUser;
  String folderDB;
  String linkImage;

  UpdateImageParams({
    this.idUser,
    required this.path,
    required this.folderDB,
    required this.linkImage,
  });
}
