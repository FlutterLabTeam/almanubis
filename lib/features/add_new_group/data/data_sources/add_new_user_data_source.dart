import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class AddNewUserDataSource {
  Future<List<UserModel>> getAllUser();
  Future<List<UserModel>> searchUser(String text);
}

class AddNewUserDataSourceImpl implements AddNewUserDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AddNewUserDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      QuerySnapshot data = await firestore.collection("users").where("rol", isEqualTo:  "USER").get();
      List<UserModel> listUser = data.docs.map((e) => UserModel.fromJson(e, e.id)).toList();
      return listUser;
    } catch (e) {
      throw GetAllUserException();
    }
  }

  @override
  Future<List<UserModel>> searchUser(String text) async {
    try {
      QuerySnapshot data = await firestore.collection("users").where("query", arrayContains: text).get();
      List<UserModel> listUser = data.docs.map((e) => UserModel.fromJson(e, e.id)).toList();
      return listUser;
    } catch (e) {
      throw GetAllUserException();
    }
  }
}
