import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/features/list_chat/data/data_sources/list_chat_data_source.dart';
import 'package:almanubis/features/list_chat/domain/repositories/list_chat_repository.dart';

class ListChatRepositoryImpl implements ListChatRepository{
  final ListChatDataSource listChatDataSource;

  ListChatRepositoryImpl({required this.listChatDataSource});


  @override
  Future<Either<Failure, List<GroupModel>>> getListChat() async {
    try {
      final result = await listChatDataSource.getListChat();
      return Right(result);
    } on GetListGroupException {
      return Left(ValidateUserLoggedFailure());
    }
  }
}
