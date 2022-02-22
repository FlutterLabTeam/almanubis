import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum ColorType {
  light,
  dark,
}

class CustomCircularProgressIndicator extends StatelessWidget {
  final ColorType? colorType;

  const CustomCircularProgressIndicator({
    Key? key,
    this.colorType = ColorType.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: generateBackgroundColor(colorType!),
      color: generateColor(colorType!),
    );
  }

  Color generateBackgroundColor(ColorType colorType){
    switch(colorType){
      case ColorType.light:
        return CompanyColor.color().second;
      case ColorType.dark:
        return CompanyColor.color().primary;
    }
  }

  Color generateColor(ColorType colorType){
    switch(colorType){
      case ColorType.light:
        return CompanyColor.color().third;
      case ColorType.dark:
        return CompanyColor.color().second;
    }
  }
}
