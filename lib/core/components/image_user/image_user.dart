import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_colors.dart';

enum ImageUserColor {
  light,
  dark,
}

class ImageUserModel {
  final String image;
  final IconData icon;
  final double? size;
  final ImageUserColor? color;
  final Function handledIcon;

  ImageUserModel({
    this.size = 50,
    required this.icon,
    required this.image,
    required this.handledIcon,
    this.color = ImageUserColor.light,
  });
}

class ImageUser extends StatelessWidget {

  final ImageUserModel model;

  const ImageUser({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: model.size,
          width: model.size,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: handledGenerateBackColor(model.color!),
                blurRadius: 2,
                spreadRadius: 2
              )
            ],
            border: Border.all(
              width: 1,
              color: handledGenerateColor(model.color!),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                model.image,
              ),
            ),
          ),
        ),
        Container(
          width: model.size!/2,
          height: model.size!/2,
          color: handledGenerateColor(model.color!),
          child: Icon(
            Icons.clear,
            size: model.size!/2,
            color: handledGenerateIconColor(model.color!),
          ),
        )
      ],
    );
  }

  Color handledGenerateColor(ImageUserColor customChatColor) {
    switch (customChatColor) {
      case ImageUserColor.light:
        return CompanyColor.color().second;
      case ImageUserColor.dark:
        return CompanyColor.color().primary;
    }
  }

  Color handledGenerateIconColor(ImageUserColor customChatColor) {
    switch (customChatColor) {
      case ImageUserColor.dark:
        return CompanyColor.color().third;
      case ImageUserColor.light:
        return CompanyColor.color().primary;
    }
  }

  Color handledGenerateBackColor(ImageUserColor customChatColor) {
    switch (customChatColor) {
      case ImageUserColor.light:
        return CompanyColor.color().second70;
      case ImageUserColor.dark:
        return CompanyColor.color().primary70;
    }
  }
}
