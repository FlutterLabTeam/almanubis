import 'package:flutter/cupertino.dart';
import 'package:almanubis/core/util/company_colors.dart';

class CompanyFontStyle {
  static const _undefinedStyle = TextStyle();

  final TextStyle titleApp;
  final TextStyle textStyle;
  final TextStyle titleStyle;
  final TextStyle buttonStyle;
  final TextStyle titleAppDark;
  final TextStyle subTitleStyle;
  final TextStyle titleAppLight;

  CompanyFontStyle({
    this.titleApp = _undefinedStyle,
    this.textStyle = _undefinedStyle,
    this.titleStyle = _undefinedStyle,
    this.buttonStyle = _undefinedStyle,
    this.titleAppDark = _undefinedStyle,
    this.subTitleStyle = _undefinedStyle,
    this.titleAppLight = _undefinedStyle,
  });

  factory CompanyFontStyle.style(){
    return CompanyFontStyle(
      titleStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: CompanyColor.color().primary
      ),
      subTitleStyle:  const TextStyle(
          fontSize: 18,
      ),
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      buttonStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: CompanyColor.color().primary
      ),
      titleAppLight: TextStyle(
          fontSize: 40,
          letterSpacing: 10,
          fontWeight: FontWeight.w300,
          color: CompanyColor.color().second
      ),
      titleAppDark: TextStyle(
          fontSize: 40,
          letterSpacing: 10,
          fontWeight: FontWeight.w300,
          color: CompanyColor.color().primary
      ),
    );
  }
}