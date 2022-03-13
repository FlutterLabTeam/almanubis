import 'package:almanubis/core/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:almanubis/features/list_chat/data/data_sources/list_chat_data_source.dart';
import 'package:almanubis/features/list_chat/domain/repositories/list_chat_repository.dart';

class ListChatRepositoryImpl implements ListChatRepository{
  final ListChatDataSource listChatDataSource;

  ListChatRepositoryImpl({required this.listChatDataSource});


  @override
  Future<Either<Failure, List<ChatModel>>> getListChat(String userId) async {
    try {
      final result = await listChatDataSource.getListChat(userId);
      return Right(result);
    } on GetListGroupException {
      return Left(ValidateUserLoggedFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot>>> getListGroupSnapShot({required bool isAdmin, required userId}) async {
    try {
      final result = await listChatDataSource.getListGroupSnapShot(userId: userId, isAdmin: isAdmin);
      return Right(result);
    } on GetListChatSnapShotException {
      return Left(ValidateUserLoggedFailure());
    }
  }
}
