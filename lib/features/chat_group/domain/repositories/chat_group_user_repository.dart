import 'package:almanubis/core/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatGroupRepository {
  Future<Either<Failure, Stream<QuerySnapshot>>> getStreamChat({required String idGroup});
  Future<Either<Failure, bool>> createChat({required ChatModel chatModel});
}
