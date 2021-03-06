import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
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
  final Function() handledIcon;
  final bool? loadingButton;

  CustomFloatingButtonModel({
    this.size = 40,
    required this.icon,
    required this.handledIcon,
    this.loadingButton = false,
    this.color = CustomFloatingButtonColor.light,
  });
}

class CustomFloatingButton extends StatelessWidget {
  final CustomFloatingButtonModel model;

  const CustomFloatingButton({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => model.handledIcon(),
      backgroundColor: handledGenerateColor(model.color!),
      shape: const RoundedRectangleBorder(),
      child: model.loadingButton!
          ? const CustomCircularProgressIndicator(
              colorType: ColorType.dark,
            )
          : Icon(
              model.icon,
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
