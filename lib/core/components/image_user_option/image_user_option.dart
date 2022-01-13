import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_colors.dart';

enum ImageUserOptionColor {
  light,
  dark,
}

class ImageUserOptionModel {
  final String image;
  final IconData icon;
  final double? size;
  final ImageUserOptionColor? color;
  final Function handledIcon;

  ImageUserOptionModel({
    this.size = 50,
    required this.icon,
    required this.image,
    required this.handledIcon,
    this.color = ImageUserOptionColor.light,
  });
}

class ImageUserOption extends StatelessWidget {

  final ImageUserOptionModel model;

  const ImageUserOption({Key? key, required this.model}) : super(key: key);

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
        GestureDetector(
          onTap: ()=> model.handledIcon(),
          child: Container(
            width: model.size!/2,
            height: model.size!/2,
            color: handledGenerateColor(model.color!),
            child: Icon(
              Icons.clear,
              size: model.size!/2,
              color: handledGenerateIconColor(model.color!),
            ),
          ),
        )
      ],
    );
  }

  Color handledGenerateColor(ImageUserOptionColor customChatColor) {
    switch (customChatColor) {
      case ImageUserOptionColor.light:
        return CompanyColor.color().second;
      case ImageUserOptionColor.dark:
        return CompanyColor.color().primary;
    }
  }

  Color handledGenerateIconColor(ImageUserOptionColor customChatColor) {
    switch (customChatColor) {
      case ImageUserOptionColor.dark:
        return CompanyColor.color().third;
      case ImageUserOptionColor.light:
        return CompanyColor.color().primary;
    }
  }

  Color handledGenerateBackColor(ImageUserOptionColor customChatColor) {
    switch (customChatColor) {
      case ImageUserOptionColor.light:
        return CompanyColor.color().second70;
      case ImageUserOptionColor.dark:
        return CompanyColor.color().primary70;
    }
  }
}
