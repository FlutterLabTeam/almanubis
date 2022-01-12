import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class AuthDataSource {
  Future<User> loginEmail(String email, String password);
  Future<UserModel> getUserDb(String uid);
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<User> loginEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
}
