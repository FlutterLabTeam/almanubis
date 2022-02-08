class ChatModel {
  ChatModel({
    this.id,
    this.typeAssetsChat,
    required this.label,
    required this.idGroup,
    required this.nameUser,
    required this.pathImage,
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
  String pathImage;
  String imageUser;
  DateTime dateCreate;
  String idUserCreate;
  String? typeAssetsChat;
  List<String> listUserViewed;
  List<String> listUserReceiver;

  factory ChatModel.fromJson(json, String id) => ChatModel(
    id: id,
    label: json["label"],
    idGroup: json["idGroup"],
    nameUser: json["nameUser"],
    pathImage: json["pathImage"],
    imageUser: json["imageUser"],
    idUserCreate: json["idUserCreate"],
    typeAssetsChat: json["typeAssetsChat"],
    dateCreate: json["dateCreate"].toDate(),
    listUserViewed: List<String>.from(json["listUserViewed"].map((x) => x)),
    listUserReceiver: List<String>.from(json["listUserReceiver"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "idGroup": idGroup,
    "nameUser": nameUser,
    "pathImage": pathImage,
    "imageUser": imageUser,
    "dateCreate": dateCreate,
    "idUserCreate": idUserCreate,
    "typeAssetsChat": typeAssetsChat,
    "listUserReceiver": List<dynamic>.from(listUserReceiver.map((x) => x)),
    "listUserViewed": List<dynamic>.from(listUserViewed.map((x) => x)),
  };
}
