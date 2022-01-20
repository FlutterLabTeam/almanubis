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
    required this.description,
  });

  String? id;
  String title;
  String image;
  String description;
  List<String> query;
  DateTime dateCreate;
  DateTime? dateUpdate;
  List<UserModel> listUser;

  factory GroupModel.fromJson(json, String id) => GroupModel(
    id: id,
    image: json["image"],
    title: json["title"],
    description: json["description"],
    dateCreate: json["dateCreate"].toDate(),
    query: List<String>.from(json["query"].map((x) => x)),
    listUser: List<UserModel>.from(json["listUser"].map((x) => UserModel.fromJson(x, ""))),
    // ignore: prefer_null_aware_operators
    dateUpdate: json["dateUpdate"] != null ? json["dateUpdate"].toDate() : null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "dateUpdate": dateUpdate,
    "dateCreate": dateCreate,
    "description": description,
    "query": List<dynamic>.from(query.map((x) => x)),
    "listUser": List<dynamic>.from(listUser.map((x) => x.toJson())),
  };
}
