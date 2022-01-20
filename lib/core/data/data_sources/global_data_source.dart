import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class GlobalDataSource {
  Future<String> takePhoto();

  Future<String> saveImage({
    String? idUser,
    required String path,
    required String folderDB,
  });

  Future<String> updateImage({
    required String path,
    required String idUser,
    required String folderDB,
    required String linkImage,
  });
}

class GlobalDataSourceImpl implements GlobalDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  GlobalDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<String> takePhoto() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return image.path;
      } else {
        throw SaveNewGroupException();
      }
    } catch (e) {
      throw SaveNewGroupException();
    }
  }

  @override
  Future<String> updateImage({
    required String path,
    required String idUser,
    required String folderDB,
    required String linkImage,
  }) async {
    try {
      await firebaseStorage.refFromURL(linkImage).delete();
      final Reference reference = firebaseStorage.ref().child(folderDB);
      TaskSnapshot saveImage =
          await reference.child('$idUser.jpg').putFile(File(path));
      String urlImage = await saveImage.ref.getDownloadURL();
      firestore.collection("users").doc(idUser).update({"photoUrl": urlImage});
      return urlImage;
    } catch (e) {
      throw SaveImageException();
    }
  }

  @override
  Future<String> saveImage({
    String? idUser,
    required String path,
    required String folderDB,
  }) async {
    try {
      String name;
      if(idUser == null) {
        name = path.split("/").last;
      }else{
        name = idUser;
      }
      final Reference reference = firebaseStorage.ref().child(folderDB);
      TaskSnapshot saveImage = await reference.child("$name.jpg").putFile(File(path));
      String link = await saveImage.ref.getDownloadURL();
      return link;
    } catch (e) {
      throw SaveImageException();
    }
  }
}
