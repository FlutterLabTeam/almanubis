import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/list_chat/domain/repositories/list_chat_repository.dart';

class GetListChat extends UseCase<List<ChatModel>, String> {
  final ListChatRepository listChatRepository;

  GetListChat({required this.listChatRepository});

  @override
  Future<Either<Failure, List<ChatModel>>> call(String params) {
    return listChatRepository.getListChat(params);
  }
}
