class ChatModel {
  ChatModel({
    this.id,
    required this.label,
    required this.idGroup,
    required this.nameUser,
    required this.imageUser,
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
  List<String> listUserViewed;
  List<String> listUserReceiver;

  factory ChatModel.fromJson(json, String id) => ChatModel(
    id: id,
    label: json["label"],
    idGroup: json["idGroup"],
    nameUser: json["nameUser"],
    imageUser: json["imageUser"],
    dateCreate: json["dateCreate"].toDate(),
    idUserCreate: json["idUserCreate"],
    listUserViewed: List<String>.from(json["listUserViewed"].map((x) => x)),
    listUserReceiver: List<String>.from(json["listUserReceiver"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "idGroup": idGroup,
    "nameUser": nameUser,
    "imageUser": imageUser,
    "dateCreate": dateCreate,
    "idUserCreate": idUserCreate,
    "listUserReceiver": List<dynamic>.from(listUserReceiver.map((x) => x)),
    "listUserViewed": List<dynamic>.from(listUserViewed.map((x) => x)),
  };
}
