import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';

enum CustomButtonColor {
  light,
  dark,
}

class CustomButtonModel {
  final CustomButtonColor color;

  CustomButtonModel({this.color = CustomButtonColor.light});
}

class CustomButton extends StatelessWidget {
  final String label;
  final Function handledButton;
  final CustomButtonModel model;

  const CustomButton({
    Key? key,
    this.label = "",
    required this.model,
    required this.handledButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handledButton(),
      child: Expanded(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _getColor(model.color),
            boxShadow: [
              BoxShadow(
                  color: CompanyColor.color().second70,
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Text(
            label,
            style: CompanyFontStyle.style().buttonStyle,
          ),
        ),
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
