import 'dart:io';

import 'package:almanubis/core/model/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ChatGroupDataSource {
  Future<bool> createChat({required ChatModel chatModel});
  Future<Stream<QuerySnapshot>> getStreamChat({required String idGroup});
  Future<String> setAudio({required File file});
}

class ChatGroupDataSourceImpl implements ChatGroupDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  ChatGroupDataSourceImpl({required this.firebaseAuth, required this.firestore, required this.firebaseStorage});

  @override
  Future<Stream<QuerySnapshot>> getStreamChat({required String idGroup}) async {
    try {
      Stream<QuerySnapshot> data = firestore.collection("chats").where("idGroup", isEqualTo: idGroup).snapshots();
      return data;
    } catch (e) {
      throw GetStreamChatException();
    }
  }

  @override
  Future<bool> createChat({required ChatModel chatModel}) async {
    try {
       await firestore.collection("chats").add(chatModel.toJson());
      return true;
    } catch (e) {
      throw CreateChatException();
    }
  }

  @override
  Future<String> setAudio({required File file}) async {
    try {
      String audioPath = file.path;
      Reference storageReference = FirebaseStorage.instance.ref("audio");
      TaskSnapshot saveAudio = await storageReference.child(audioPath.substring(audioPath.lastIndexOf("/"), audioPath.length)).putFile(file, SettableMetadata(contentType: 'audio/wav'));
      String url =  await saveAudio.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw CreateChatException();
    }
  }
}
