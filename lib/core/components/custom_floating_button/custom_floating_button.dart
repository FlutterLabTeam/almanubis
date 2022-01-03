import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_colors.dart';

enum CustomFloatingButtonColor {
  light,
  dark,
}

class CustomFloatingButtonModel {
  final IconData icon;
  final double? size;
  final CustomFloatingButtonColor? color;
  final Function handledIcon;

  CustomFloatingButtonModel({
    this.size = 40,
    required this.icon,
    required this.handledIcon,
    this.color = CustomFloatingButtonColor.light,
  });
}

class CustomFloatingButton extends StatelessWidget {
  final CustomFloatingButtonModel model;

  const CustomFloatingButton({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => model.handledIcon,
      backgroundColor: handledGenerateColor(model.color!),
      shape: const RoundedRectangleBorder(),
      child: Icon(
        Icons.add,
        size: model.size!,
        color: handledGenerateIconColor(model.color!),
      ),
    );
  }

  Color handledGenerateColor(CustomFloatingButtonColor customChatColor) {
    switch (customChatColor) {
      case CustomFloatingButtonColor.light:
        return CompanyColor.color().second;
      case CustomFloatingButtonColor.dark:
        return CompanyColor.color().primary;
    }
  }

  Color handledGenerateIconColor(CustomFloatingButtonColor customChatColor) {
    switch (customChatColor) {
      case CustomFloatingButtonColor.dark:
        return CompanyColor.color().third;
      case CustomFloatingButtonColor.light:
        return CompanyColor.color().primary;
    }
  }
}
