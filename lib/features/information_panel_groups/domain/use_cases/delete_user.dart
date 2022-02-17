import 'package:almanubis/core/model/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/information_panel_groups/domain/repositories/information_panel_repository.dart';

class DeleteUser extends UseCase<UserModel, DeleteUserParams> {
  final InformationPanelRepository informationPanelRepository;

  DeleteUser({required this.informationPanelRepository});

  @override
  Future<Either<Failure, UserModel>> call(DeleteUserParams params) {
    return informationPanelRepository.deleteUser(
      idGroup: params.idGroup,
      user: params.user,
    );
  }
}

class DeleteUserParams {
  final String idGroup;
  final UserModel user;

  DeleteUserParams({
    required this.user,
    required this.idGroup,
  });
}
