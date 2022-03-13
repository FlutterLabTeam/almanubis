import 'package:almanubis/core/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ListChatDataSource {
  Future<List<ChatModel>> getListChat(String userId);
  Future<Stream<QuerySnapshot>> getListGroupSnapShot({required bool isAdmin, required userId});
}

class ListChatDataSourceImpl implements ListChatDataSource {
  final FirebaseFirestore firestore;
  final SharedPreferences sharedPreferences;

  ListChatDataSourceImpl({
    required this.firestore,
    required this.sharedPreferences,
  });

  @override
  Future<List<ChatModel>> getListChat(String userId) async {
    try {
      var _userCollection = FirebaseFirestore.instance.collection('chats');
      QuerySnapshot response = await _userCollection.where("listUserReceiver", arrayContains: userId).get();
      List<ChatModel> listChat = response.docs.map((e) => ChatModel.fromJson(e.data(), e.id)).toList();
      return listChat;
    } catch (e) {
      throw GetListGroupException();
    }
  }

  @override
  Future<Stream<QuerySnapshot>> getListGroupSnapShot({required bool isAdmin, required userId}) async {
    try {
      Stream<QuerySnapshot> _listChatsSnapShot;
      if(isAdmin){
        _listChatsSnapShot = FirebaseFirestore.instance.collection('groups').snapshots();
      }else{
        _listChatsSnapShot = FirebaseFirestore.instance.collection('groups').where("listUserId", arrayContains: userId).snapshots();
      }
      return _listChatsSnapShot;
    } catch (e) {
      throw GetListChatSnapShotException();
    }
  }
}
