import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/company_colors.dart';

enum CustomButtonColor {
  light,
  dark,
}

class CustomButtonModel {
  final CustomButtonColor color;
  final String label;
  final Function handledButton;

  CustomButtonModel({
    this.label = "",
    required this.handledButton,
    this.color = CustomButtonColor.light,
  });
}

class CustomButton extends StatelessWidget {
  final CustomButtonModel model;

  const CustomButton({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: CompanyColor.color().second70,
      color: _getColor(model.color),
      child: InkWell(
        onTap: () => model.handledButton(),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            model.label,
            style: CompanyFontStyle.style().buttonStyle,
          ),
        )
      ),
    );
  }

  Color _getColor(CustomButtonColor color) {
    switch (color) {
      case CustomButtonColor.light:
        return CompanyColor.color().third;
      case CustomButtonColor.dark:
        return CompanyColor.color().second;
      default:
        return Colors.black;
    }
  }
}
