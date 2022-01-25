import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class AddNewUserDataSource {
  Future<List<UserModel>> getAllUser();
  Future<List<UserModel>> searchUser(String text);
  Future<bool> addNewUser({required List<UserModel> user, required String idGroup});
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

  @override
  Future<bool> addNewUser({required List<UserModel> user, required String idGroup}) async {
    try {
      List listUserModel = user.map((e) => e.toJsonGroup()).toList();
      List listUserIdModel = user.map((e) => e.uid!).toList();
      await firestore.collection("groups").doc(idGroup).update({"listUser": FieldValue.arrayUnion(listUserModel)});
      await firestore.collection("groups").doc(idGroup).update({"listUserNotify": FieldValue.arrayUnion(listUserIdModel)});
      return true;
    } catch (e) {
      throw GetAllUserException();
    }
  }
}
