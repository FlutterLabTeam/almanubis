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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    rol: json["rol"],
    uid: json["uid"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    dateCreate: json["dateCreate"],
    dateUpdate: json["dateUpdate"],
    description: json["description"],
    query: List<String>.from(json["query"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
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
