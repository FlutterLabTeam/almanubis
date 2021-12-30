class UserModel {
  UserModel({
    required this.name,
    required this.image,
  });

  String name;
  String image;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
