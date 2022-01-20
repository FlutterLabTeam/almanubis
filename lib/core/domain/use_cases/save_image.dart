import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/core/domain/repositories/global_repository.dart';

class SaveImage extends UseCase<String, SaveImageParams> {
  final GlobalRepository globalRepository;

  SaveImage({required this.globalRepository});

  @override
  Future<Either<Failure, String>> call(SaveImageParams params) {
    return globalRepository.saveImage(
      path: params.path,
      idUser: params.idUser,
      folderDB: params.folderDB,
    );
  }
}

class SaveImageParams {
  String path;
  String? idUser;
  String folderDB;

  SaveImageParams({
    this.idUser,
    required this.path,
    required this.folderDB,
  });
}
/*class SaveImageParams {
  String path;
  String idUser;
  String folderDB;
  String linkImage;

  SaveImageParams({
    required this.folderDB,
    required this.idUser,
    required this.path,
    required this.linkImage,
  });
}*/