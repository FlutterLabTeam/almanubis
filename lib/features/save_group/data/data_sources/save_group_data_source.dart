import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class SaveGroupDataSource {
  Future<GroupModel> saveNewGroup(GroupModel groupModel);
}

class SaveGroupDataSourceImpl implements SaveGroupDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  SaveGroupDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<GroupModel> saveNewGroup(GroupModel groupModel) async {
    try {
      DocumentReference data = await firestore.collection("groups").add(groupModel.toJson());
      groupModel.id = data.id;
      return groupModel;
    } catch (e) {
      throw SaveNewGroupException();
    }
  }
}
