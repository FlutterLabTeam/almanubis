import 'package:almanubis/core/data/model/image_quality_model.dart';

Map<String, double> generateSizeImage(ImageSizeEnum imageSizeEnum) {
  double maxHeight = 0.0;
  double maxWidth = 0.0;
  switch (imageSizeEnum) {
    case ImageSizeEnum.xxl:
      maxHeight = 800;
      maxWidth = 400;
      break;
    case ImageSizeEnum.xl:
      maxHeight = 600;
      maxWidth = 300;
      break;
    case ImageSizeEnum.l:
      maxHeight = 400;
      maxWidth = 200;
      break;
    case ImageSizeEnum.m:
      maxHeight = 300;
      maxWidth = 150;
      break;
    case ImageSizeEnum.s:
      maxHeight = 260;
      maxWidth = 130;
      break;
    case ImageSizeEnum.xs:
      maxHeight = 200;
      maxWidth = 100;
      break;
  }
  return {"height": maxHeight, "width": maxWidth};
}