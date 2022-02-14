import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:almanubis/core/util/generate_size_image.dart';
import 'package:almanubis/core/util/link_image_to_name.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:almanubis/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

abstract class GlobalDataSource {
  Future<String> takeVideo();
  Future<String> takePhoto({required ImageQualityModel imageQualityModel});
  Future<String> takeImage({required ImageQualityModel imageQualityModel});
  Future<bool> downloadAssets({required String folderDB, required String path});
  Future<String> saveImage({
    String? idUser,
    required String path,
    required String folderDB,
  });
  Future<String> updateImage({
    String? idUser,
    required String path,
    required String folderDB,
    required String linkImage,
  });
}

class GlobalDataSourceImpl implements GlobalDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  GlobalDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<String> takePhoto(
      {required ImageQualityModel imageQualityModel}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: generateSizeImage(imageQualityModel.size!)["height"],
          maxWidth: generateSizeImage(imageQualityModel.size!)["width"],
          imageQuality: imageQualityModel.imageQuality);
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
    String? idUser,
    required String path,
    required String folderDB,
    required String linkImage,
  }) async {
    try {
      final Reference reference = firebaseStorage.ref().child(folderDB);
      TaskSnapshot updateImage =
          await reference.child('$idUser.jpg').putFile(File(path));
      String link = await updateImage.ref.getDownloadURL();
      return link;
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
      if (idUser == null) {
        name = path.split("/").last;
      } else {
        name = idUser;
      }
      final Reference reference = firebaseStorage.ref().child(folderDB);
      TaskSnapshot saveImage = await reference.child(name).putFile(File(path));
      String link = await saveImage.ref.getDownloadURL();
      return link;
    } catch (e) {
      throw SaveImageException();
    }
  }

  @override
  Future<bool> downloadAssets(
      {required String folderDB, required String path}) async {
    try {
      path = linkImageToName(path);
      final Reference reference = firebaseStorage.ref().child(path);
      final Directory dir = await getApplicationDocumentsDirectory();
      String link = "${dir.path}/${reference.name}";
      await reference.writeToFile(File(link));
      return true;
    } catch (e) {
      throw SaveImageException();
    }
  }

  @override
  Future<String> takeImage({
    required ImageQualityModel imageQualityModel,
  }) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: generateSizeImage(imageQualityModel.size!)["height"],
          maxWidth: generateSizeImage(imageQualityModel.size!)["width"],
          imageQuality: imageQualityModel.imageQuality);
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
  Future<String> takeVideo() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? video = await _picker.pickVideo(source: ImageSource.gallery, maxDuration: const Duration(minutes: 1));
      if (video != null) {
        return video.path;
      } else {
        throw SaveNewGroupException();
      }
    } catch (e) {
      throw SaveNewGroupException();
    }
  }
}
