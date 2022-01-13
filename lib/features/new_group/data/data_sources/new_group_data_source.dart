import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class NewGroupDataSource {
  Future<List<UserModel>> getAllUser();
}

class NewGroupDataSourceImpl implements NewGroupDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  NewGroupDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      QuerySnapshot data = await firestore.collection("users").where("rol", isEqualTo:  "USER").get();
      List<UserModel> listUser = data.docs.map((e) => UserModel.fromJson(e, e.id)).toList();
      return listUser;
    } catch (e) {
      throw GetAllUserByNewGroupException();
    }
  }
}
