import 'package:almanubis/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';

abstract class InformationPanelDataSource {
  Future<bool> activeNotification({
    required String idGroup,
    required String idUser,
  });

  Future<bool> disableNotification({
    required String idGroup,
    required String idUser,
  });
  Future<UserModel> deleteUser({
    required String idGroup,
    required UserModel user,
  });
}

class InformationPanelDataSourceImpl implements InformationPanelDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  InformationPanelDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});

  @override
  Future<bool> activeNotification({
    required String idGroup,
    required String idUser,
  }) async {
    try {
      await firestore.collection("groups").doc(idGroup).update({
        "listUserNotify": FieldValue.arrayUnion([idUser])
      });
      return true;
    } catch (e) {
      throw RegisterEmailException();
    }
  }

  @override
  Future<bool> disableNotification({
    required String idGroup,
    required String idUser,
  }) async {
    try {
      await firestore.collection("groups").doc(idGroup).update({
        "listUserNotify": FieldValue.arrayRemove([idUser])
      });
      return true;
    } catch (e) {
      throw RegisterEmailException();
    }
  }

  @override
  Future<UserModel> deleteUser({
    required String idGroup,
    required UserModel user,
  }) async {
    try {
      await firestore.collection("groups").doc(idGroup).update({"listUser": FieldValue.arrayRemove([user.toJsonGroup()])});

      return user;
    } catch (e) {
      throw RegisterEmailException();
    }
  }
}
