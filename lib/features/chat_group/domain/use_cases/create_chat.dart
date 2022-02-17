import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/chat_group/domain/repositories/chat_group_user_repository.dart';

class CreateChat extends UseCase<bool, ChatModel> {
  final ChatGroupRepository chatGroupRepository;

  CreateChat({required this.chatGroupRepository});

  @override
  Future<Either<Failure, bool>> call(ChatModel params) {
    return chatGroupRepository.createChat(chatModel: params);
  }
}