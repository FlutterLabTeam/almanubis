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
  final TextStyle textCartDarkStyle;
  final TextStyle labelCounterStyle;
  final TextStyle textCartLightStyle;

  CompanyFontStyle({
    this.titleApp = _undefinedStyle,
    this.textStyle = _undefinedStyle,
    this.titleStyle = _undefinedStyle,
    this.buttonStyle = _undefinedStyle,
    this.titleAppDark = _undefinedStyle,
    this.subTitleStyle = _undefinedStyle,
    this.titleAppLight = _undefinedStyle,
    this.textCartDarkStyle = _undefinedStyle,
    this.labelCounterStyle = _undefinedStyle,
    this.textCartLightStyle = _undefinedStyle,
  });

  factory CompanyFontStyle.style(){
    return CompanyFontStyle(
      titleStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: CompanyColor.color().primary
      ),
      labelCounterStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: CompanyColor.color().primary
      ),
      subTitleStyle:  const TextStyle(
          fontSize: 18,
      ),
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      textCartLightStyle: TextStyle(
          fontSize: 12,
          color: CompanyColor.color().second,
          fontWeight: FontWeight.w400
      ),
      textCartDarkStyle: TextStyle(
          fontSize: 12,
          color: CompanyColor.color().primary,
          fontWeight: FontWeight.w400
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