import 'package:almanubis/core/model/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ListChatDataSource {
  Future<List<GroupModel>> getListChat();
}

class ListChatDataSourceImpl implements ListChatDataSource {
  final FirebaseFirestore firestore;
  final SharedPreferences sharedPreferences;

  ListChatDataSourceImpl({
    required this.firestore,
    required this.sharedPreferences,
  });

  @override
  Future<List<GroupModel>> getListChat() async {
    try {
      var _userCollection = FirebaseFirestore.instance.collection('groups');
      QuerySnapshot response = await _userCollection.get();
      List<GroupModel> listChat = response.docs.map((e) => GroupModel.fromJson(e.data(), e.id)).toList();
      return listChat;
    } catch (e) {
      throw GetListGroupException();
    }
  }
}
