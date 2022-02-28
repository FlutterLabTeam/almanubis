import 'package:almanubis/features/chat_group/data/models/audio_model.dart';

class ChatModel {
  ChatModel({
    this.id,
    required this.label,
    required this.idGroup,
    required this.nameUser,
    required this.imageUser,
    required this.dataAsset,
    required this.dateCreate,
    required this.idUserCreate,
    required this.listUserViewed,
    required this.listUserReceiver,
  });

  String? id;
  String label;
  String idGroup;
  String nameUser;
  String imageUser;
  DateTime dateCreate;
  String idUserCreate;
  AssetModel dataAsset;
  List<String> listUserViewed;
  List<String> listUserReceiver;

  factory ChatModel.fromJson(json, String id) => ChatModel(
    id: id,
    label: json["label"],
    idGroup: json["idGroup"],
    nameUser: json["nameUser"],
    dataAsset: AssetModel.fromJson(json["dataAsset"]),
    imageUser: json["imageUser"],
    idUserCreate: json["idUserCreate"],
    dateCreate: json["dateCreate"].toDate(),
    listUserViewed: List<String>.from(json["listUserViewed"].map((x) => x)),
    listUserReceiver: List<String>.from(json["listUserReceiver"].map((x) => x)),
  );

  factory ChatModel.fromJsonNoData({String? idGroup, List<String>? listUserReceiver}) => ChatModel(
    id: '',
    label: "",
    nameUser: "",
    imageUser: "",
    idUserCreate: "",
    listUserViewed: [],
    idGroup: idGroup??"",
    dateCreate: DateTime.now(),
    dataAsset: AssetModel.fromJsonNoData(),
    listUserReceiver: listUserReceiver??[],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "idGroup": idGroup,
    "nameUser": nameUser,
    "imageUser": imageUser,
    "dateCreate": dateCreate,
    "idUserCreate": idUserCreate,
    "dataAsset": dataAsset.toJson(),
    "listUserReceiver": List<dynamic>.from(listUserReceiver.map((x) => x)),
    "listUserViewed": List<dynamic>.from(listUserViewed.map((x) => x)),
  };
}
