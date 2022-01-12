class UserModel {
  UserModel({
    this.uid,
    this.image,
    this.dateUpdate,
    this.description,
    required this.rol,
    required this.name,
    required this.email,
    required this.query,
    required this.dateCreate,
  });

  String rol;
  String name;
  String? uid;
  String email;
  String? image;
  List<String> query;
  String? description;
  DateTime dateCreate;
  DateTime? dateUpdate;

  factory UserModel.fromJson(Map<String, dynamic> json, String id) => UserModel(
    uid: id,
    rol: json["rol"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    // ignore: prefer_null_aware_operators
    dateCreate: json["dateCreate"] != null ? json["dateCreate"].toDate() : null,
    // ignore: prefer_null_aware_operators
    dateUpdate: json["dateUpdate"] != null ? json["dateUpdate"].toDate() : null,
    description: json["description"],
    query: List<String>.from(json["query"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "rol": rol,
    "name": name,
    "email": email,
    "image": image,
    "dateUpdate": dateUpdate,
    "dateCreate": dateCreate,
    "description": description,
    "query": List<dynamic>.from(query.map((x) => x)),
  };
}
