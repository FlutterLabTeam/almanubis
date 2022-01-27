import 'package:almanubis/core/model/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class ChatGroupDataSource {
  Future<bool> createChat({required ChatModel chatModel});
  Future<Stream<QuerySnapshot>> getStreamChat({required String idGroup});
}

class ChatGroupDataSourceImpl implements ChatGroupDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  ChatGroupDataSourceImpl({required this.firebaseAuth, required this.firestore});

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
}
