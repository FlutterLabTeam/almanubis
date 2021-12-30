class ChatModel {
  ChatModel({
    required this.label,
    required this.dateCreate,
  });

  String label;
  DateTime dateCreate;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    label: json["label"],
    dateCreate: json["dateCreate"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "dateCreate": dateCreate,
  };
}
