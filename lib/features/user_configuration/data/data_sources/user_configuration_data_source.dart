import 'package:firebase_auth/firebase_auth.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class UserConfigurationDataSource {
  Future<bool> updateUser(UserModel userModel);
}

class UserConfigurationDataSourceImpl implements UserConfigurationDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserConfigurationDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<bool> updateUser(UserModel userModel) async {
    try {
      await firestore.collection("users").doc(userModel.uid).update(userModel.toJson());
      return true;
    } catch (e) {
      throw SaveNewGroupException();
    }
  }
}
