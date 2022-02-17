import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/chat_group/domain/repositories/chat_group_user_repository.dart';

class ReadingChat extends UseCase<bool, ReadingChatParams> {
  final ChatGroupRepository chatGroupRepository;

  ReadingChat({required this.chatGroupRepository});

  @override
  Future<Either<Failure, bool>> call(ReadingChatParams params) {
    return chatGroupRepository.readingChat(listIdChat: params.listChatId, userId: params.userId);
  }
}

class ReadingChatParams{

  final String userId;
  final List<String> listChatId;

  ReadingChatParams({required this.listChatId, required this.userId});
}