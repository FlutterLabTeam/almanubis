import 'dart:io';

import 'package:almanubis/core/model/chat_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almanubis/core/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:almanubis/features/chat_group/data/data_sources/chat_group_data_source.dart';
import 'package:almanubis/features/chat_group/domain/repositories/chat_group_user_repository.dart';

class ChatGroupRepositoryImpl implements ChatGroupRepository {
  final ChatGroupDataSource chatGroupDataSource;

  ChatGroupRepositoryImpl({required this.chatGroupDataSource});

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>>> getStreamChat({required String idGroup}) async {
    try {
      final response = await chatGroupDataSource.getStreamChat(idGroup: idGroup);
      return Right(response);
    } on GetStreamChatException {
      return Left(RegisterUserDbFailure());
    }
  }

  @override
  Future<Either<Failure, bool>>  createChat({required ChatModel chatModel}) async {
    try {
      final response = await chatGroupDataSource.createChat(chatModel: chatModel);
      return Right(response);
    } on CreateChatException {
      return Left(RegisterUserDbFailure());
    }
  }


  @override
  Future<Either<Failure, String>> saveAudio({required File file}) async {
    try {
      final response = await chatGroupDataSource.setAudio(
        file: file
      );
      return Right(response);
    } on RegisterEmailException {
      return Left(RegisterEmailFailure());
    }
  }
}
