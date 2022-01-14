import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class SaveGroupDataSource {
  Future<bool> saveNewGroup(GroupModel groupModel);
}

class SaveGroupDataSourceImpl implements SaveGroupDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  SaveGroupDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<bool> saveNewGroup(GroupModel groupModel) async {
    try {
      await firestore.collection("groups").add(groupModel.toJson());
      return true;
    } catch (e) {
      throw SaveNewGroupException();
    }
  }
}
