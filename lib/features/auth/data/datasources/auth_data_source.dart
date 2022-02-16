import 'dart:convert';

import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/features/auth/data/models/credentials_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {
  Future<UserModel> getUserDb(String uid);

  Future<CredentialsModel> validateUserLogged();

  Future<bool> setDataUSer(UserModel userModel);

  Future<User> loginEmail(String email, String password);

  Future<bool> saveUserLogged(CredentialsModel credentialsModel);
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final SharedPreferences sharedPreferences;

  AuthDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
    required this.sharedPreferences,
  });

  @override
  Future<User> loginEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      throw LoginEmailException();
    }
  }

  @override
  Future<UserModel> getUserDb(String uid) async {
    try {
      var _userCollection = FirebaseFirestore.instance.collection('users');
      var response = await _userCollection.doc(uid).get();
      UserModel user = UserModel.fromJson(response.data()!, uid);
      return user;
    } catch (e) {
      throw GetUserDbException();
    }
  }

  @override
  Future<CredentialsModel> validateUserLogged() async {
    try {
      String? credentials = sharedPreferences.getString("userCredentials");
      if (credentials != null) {
        Map<String, dynamic> data = jsonDecode(credentials);
        return CredentialsModel(
          email: data["email"],
          password: data["password"],
        );
      }
      return CredentialsModel(email: "", password: "");
    } on Exception {
      throw ValidateUserLoggedException();
    }
  }

  @override
  Future<bool> saveUserLogged(CredentialsModel credentialsModel) async {
    try {
      String data = jsonEncode(credentialsModel.toJson());
      sharedPreferences.setString("userCredentials", data);
      return true;
    } on Exception {
      throw ValidateUserLoggedException();
    }
  }

  @override
  Future<bool> setDataUSer(UserModel userModel) async {
    try {
      QuerySnapshot dataGroupQuery = await firestore.collection("groups").where("listUserId", arrayContains: userModel.uid!).get();
      List<GroupModel> dataGroup = dataGroupQuery.docs.map((e) => GroupModel.fromJson(e.data(), e.id)).toList();

      final batch = firestore.batch();

      for (var element in dataGroup) {
        element.listUser.map((e) {
          if (e.uid == userModel.uid) {
            e.token = userModel.token;
          }
          return e;
        }).toList();

        DocumentReference documentReference = firestore.collection("groups").doc(element.id!);
        batch.update(documentReference, element.toJson());
      }
      DocumentReference documentReference = firestore.collection("users").doc(userModel.uid);
      batch.update(documentReference, userModel.toJson());
      await batch.commit();
      return true;
    } on Exception {
      throw SaveCredentialsException();
    }
  }
}
