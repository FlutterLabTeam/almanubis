class ChatModel {
  ChatModel({
    this.id,
    required this.label,
    required this.dateCreate,
  });

  String? id;
  String label;
  DateTime dateCreate;

  factory ChatModel.fromJson(json, String id) => ChatModel(
    id: id,
    label: json["label"],
    dateCreate: json["dateCreate"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "dateCreate": dateCreate,
  };
}
