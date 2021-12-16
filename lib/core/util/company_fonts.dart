import 'package:flutter/cupertino.dart';

class CompanyFontStyle {
  static const _undefinedStyle = TextStyle();

  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle textStyle;
  final TextStyle buttonStyle;

  CompanyFontStyle({
    this.titleStyle = _undefinedStyle,
    this.subTitleStyle = _undefinedStyle,
    this.textStyle = _undefinedStyle,
    this.buttonStyle = _undefinedStyle
  });

  factory CompanyFontStyle.style(){
    return CompanyFontStyle(
      titleStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
      subTitleStyle:  const TextStyle(
          fontSize: 18,
      ),
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      buttonStyle: const TextStyle(
        fontSize: 20,
      )
    );
  }
}