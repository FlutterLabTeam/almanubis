import 'package:almanubis/core/model/user_model.dart';

class GroupModel {
  GroupModel({
    required this.title,
    required this.description,
    required this.listUser,
    required this.query,
    required this.image,
    required this.dateCreate,
    this.dateUpdate,
  });

  String title;
  String description;
  List<UserModel> listUser;
  List<String> query;
  String image;
  DateTime dateCreate;
  DateTime? dateUpdate;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    title: json["title"],
    description: json["description"],
    listUser: List<UserModel>.from(json["listUser"].map((x) => UserModel.fromJson(x, ""))),
    query: List<String>.from(json["query"].map((x) => x)),
    image: json["image"],
    dateCreate: json["dateCreate"].toDate(),
    // ignore: prefer_null_aware_operators
    dateUpdate: json["dateUpdate"] != null ? json["dateUpdate"].toDate() : null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "listUser": List<dynamic>.from(listUser.map((x) => x.toJson())),
    "query": List<dynamic>.from(query.map((x) => x)),
    "image": image,
    "dateCreate": dateCreate,
    "dateUpdate": dateUpdate,
  };
}
