class AssetModel {
  AssetModel({
    this.counted = 0,
    required this.urlAsset,
    required this.typeAsset,
    required this.millisecondTime,
  });

  int? counted;
  String urlAsset;
  String typeAsset;
  String? timeString;
  int millisecondTime;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        counted: json["counted"] ?? 0,
        urlAsset: json["urlAsset"],
        typeAsset: json["typeAsset"],
        millisecondTime: json["millisecondTime"] ?? 0,
      );

  factory AssetModel.fromJsonNoData(Map<String, dynamic> json) => AssetModel(
    counted: 0,
    urlAsset: "",
    typeAsset: "",
    millisecondTime: 0,
  );

  Map<String, dynamic> toJson() => {
        "urlAsset": urlAsset,
        "typeAsset": typeAsset,
        "millisecondTime": millisecondTime
      };
}
