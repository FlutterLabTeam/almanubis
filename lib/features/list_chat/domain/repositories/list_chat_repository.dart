import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class ListChatRepository {
  Future<Either<Failure, List<ChatModel>>> getListChat(String userId);
  Future<Either<Failure, Stream<QuerySnapshot>>> getListChatSnapShot();
}
