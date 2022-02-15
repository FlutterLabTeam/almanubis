import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/list_chat/domain/repositories/list_chat_repository.dart';

class GetListChatSnapShot extends UseCase<Stream<QuerySnapshot>, NoParams> {
  final ListChatRepository listChatRepository;

  GetListChatSnapShot({required this.listChatRepository});

  @override
  Future<Either<Failure, Stream<QuerySnapshot>>> call(NoParams params) {
    return listChatRepository.getListChatSnapShot();
  }
}
