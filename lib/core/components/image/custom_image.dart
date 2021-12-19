import 'package:flutter/cupertino.dart';
enum CustomImageColor {
  light,
  dark,
}


class CustomImageModel {
  final CustomImageColor color;

  CustomImageModel({
    this.color = CustomImageColor.light,
  });
}

class CustomImage extends StatelessWidget {
  final CustomImageModel model;

  const CustomImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(_getColor(model.color));
  }

  String _getColor(CustomImageColor color) {
    switch (color) {
      case CustomImageColor.light:
        return "assets/image/Logo2.png";
      case CustomImageColor.dark:
        return "assets/image/Logo1.png";
    }
  }
}
