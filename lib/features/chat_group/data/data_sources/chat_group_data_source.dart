import 'dart:io';

import 'package:almanubis/core/model/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_compress/video_compress.dart';

abstract class ChatGroupDataSource {
  Future<String> setAudio({required File file});
  Future<String> saveVideo({required File file});
  Future<bool> createChat({required ChatModel chatModel});
  Future<Stream<QuerySnapshot>> getStreamChat({required String idGroup});
  Future<bool> readingChat({required List<String> listIdChat, required String userId});
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

  @override
  Future<String> saveVideo({required File file}) async {
    try {
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.Res640x480Quality,
        deleteOrigin: true,
      );
      String newPath = mediaInfo != null ? mediaInfo.path! : file.path;
      String name = file.path.split("/").last;
      Reference storageReference = FirebaseStorage.instance.ref("video");
      TaskSnapshot saveAudio = await storageReference.child(name).putFile(File(newPath));
      String url =  await saveAudio.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw CreateChatException();
    }
  }

  @override
  Future<bool> readingChat({required List<String> listIdChat, required String userId}) async {
    try {
      final batch = firestore.batch();
      listIdChat.forEach((element) {
        DocumentReference documentReference = firestore.collection("chats").doc(element);
        batch.update(documentReference, {"listUserReceiver": FieldValue.arrayRemove([userId])});
        batch.update(documentReference, {"listUserViewed": FieldValue.arrayUnion([userId])});
      });
        await batch.commit();
        return true;
    } catch (e) {
      throw CreateChatException();
    }
  }
}
