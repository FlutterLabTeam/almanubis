import 'package:almanubis/core/model/user_model.dart';

class GroupModel {
  GroupModel({
    this.dateUpdate,
    this.id,
    required this.image,
    required this.title,
    required this.query,
    required this.listUser,
    required this.dateCreate,
    required this.listUserId,
    required this.description,
    required this.listUserNotify,
  });

  String? id;
  String title;
  String image;
  String description;
  List<String> query;
  DateTime dateCreate;
  DateTime? dateUpdate;
  List<String> listUserId;
  List<UserModel> listUser;
  List<String> listUserNotify;

  factory GroupModel.fromJson(json, String id) => GroupModel(
    id: id,
    image: json["image"],
    title: json["title"],
    description: json["description"],
    dateCreate: json["dateCreate"].toDate(),
    query: List<String>.from(json["query"].map((x) => x)),
    listUserNotify: json["listUserNotify"] != null ?  List<String>.from(json["listUserNotify"].map((x) => x)) : [],
    listUserId: json["listUserId"] != null ?  List<String>.from(json["listUserId"].map((x) => x)) : [],
    listUser: List<UserModel>.from(json["listUser"].map((x) => UserModel.fromJson(x, x["uid"]))),
    // ignore: prefer_null_aware_operators
    dateUpdate: json["dateUpdate"] != null ? json["dateUpdate"].toDate() : null,
  );

  factory GroupModel.fromNoDataJson() => GroupModel(
    id: "",
    image: "",
    title: "",
    query: [],
    listUser: [],
    description: "",
    listUserNotify: [],
    listUserId: [],
    dateCreate: DateTime.now(),
    dateUpdate: DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "dateUpdate": dateUpdate,
    "dateCreate": dateCreate,
    "description": description,
    "listUserId": listUserId,
    "query": List<dynamic>.from(query.map((x) => x)),
    "listUser": List<dynamic>.from(listUser.map((x) => x.toJsonGroup())),
    "listUserNotify": listUserNotify.isNotEmpty ? List<dynamic>.from(listUserNotify.map((x) => x)) : [],
  };
}
