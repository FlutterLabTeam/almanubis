import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class NewUserDataSource {
  Future<UserModel> registerDb(UserModel user);
  Future<User> registerEmail(String email, String password);
}

class NewUserDataSourceImpl implements NewUserDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  NewUserDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<User> registerEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } catch (e) {
      throw RegisterEmailException();
    }
  }

  @override
  Future<UserModel> registerDb(UserModel user) async {
    try {
      var _userCollection = FirebaseFirestore.instance.collection('users');
      Map<String, dynamic> map = user.toJson();
      await _userCollection.doc(user.uid).set(map);
      return user;
    } catch (e) {
      throw RegisterUseDbException();
    }
  }
}
