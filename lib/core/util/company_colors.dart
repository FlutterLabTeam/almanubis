import 'package:flutter/material.dart';

class CompanyColor {
  static const _defaultColor = Color(0x00000000);

  final Color primary;
  final Color primary40;
  final Color primary70;
  final Color primary90;
  final Color second;
  final Color second40;
  final Color second70;
  final Color second80;
  final Color primary80;
  final Color third;

 const CompanyColor({
    this.primary = _defaultColor,
    this.primary40 = _defaultColor,
    this.primary70 = _defaultColor,
    this.primary80 = _defaultColor,
    this.primary90 = _defaultColor,

    this.second = _defaultColor,
    this.second40 = _defaultColor,
    this.second70 = _defaultColor,
    this.second80 = _defaultColor,

   this.third = _defaultColor,
  });

  factory CompanyColor.color(){
    return const CompanyColor(
      primary: Color(0xFF4A3D59),
      primary80: Color.fromARGB(203, 74, 61, 89),
      primary90: Color.fromARGB(230, 74, 61, 89),
      primary70: Color.fromARGB(74, 74, 61, 89),
      primary40: Color.fromARGB(40, 74, 61, 89),
      second: Color(0xFF64CCB8),
      second80: Color.fromARGB(203, 100, 204, 184),
      second70: Color.fromARGB(70, 100, 204, 184),
      second40: Color.fromARGB(40, 100, 204, 184),
      third: Color(0xFFFFFFFF),
    );
  }
}