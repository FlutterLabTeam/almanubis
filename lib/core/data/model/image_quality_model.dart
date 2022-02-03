enum ImageSizeEnum {
  xxl,
  xl,
  l,
  m,
  s,
  xs
}

class ImageQualityModel {
  ImageQualityModel({
    this.size = ImageSizeEnum.m,
    this.imageQuality = 60,
  });

  int? imageQuality;
  ImageSizeEnum? size;

  factory ImageQualityModel.fromJson(Map<String, dynamic> json) => ImageQualityModel(
    imageQuality: json["imageQuality"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "imageQuality": imageQuality,
    "size": size,
  };
}
