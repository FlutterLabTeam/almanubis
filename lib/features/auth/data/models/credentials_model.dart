class CredentialsModel {
  CredentialsModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory CredentialsModel.fromJson(Map<String, dynamic> json) => CredentialsModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
