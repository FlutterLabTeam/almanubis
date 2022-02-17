import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import 'package:almanubis/core/usecases/use_cases.dart';
import 'package:almanubis/features/chat_group/domain/repositories/chat_group_user_repository.dart';

class SaveAudio extends UseCase<String, File> {
  final ChatGroupRepository chatGroupRepository;

  SaveAudio({required this.chatGroupRepository});

  @override
  Future<Either<Failure, String>> call(File params) {
    return chatGroupRepository.saveAudio(file: params);
  }
}