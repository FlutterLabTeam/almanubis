import 'dart:convert';

import 'package:almanubis/features/auth/data/models/credentials_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {

  Future<UserModel> getUserDb(String uid);
  Future<CredentialsModel> validateUserLogged();
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
}
