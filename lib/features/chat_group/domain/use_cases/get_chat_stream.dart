import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/chat_group/domain/repositories/chat_group_user_repository.dart';

class GetChatStream extends UseCase<Stream<QuerySnapshot>, String> {
  final ChatGroupRepository chatGroupRepository;

  GetChatStream({required this.chatGroupRepository});

  @override
  Future<Either<Failure, Stream<QuerySnapshot>>> call(String params) {
    return chatGroupRepository.getStreamChat(idGroup: params);
  }
}