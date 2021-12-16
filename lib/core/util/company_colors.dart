import 'package:flutter/material.dart';

class CompanyColor {
  static const _defaultColor = Color(0x00000000);

  final Color primary;
  final Color primary40;
  final Color primary70;
  final Color second;
  final Color second40;
  final Color second70;

 const CompanyColor({
    this.primary = _defaultColor,
    this.primary40 = _defaultColor,
    this.primary70 = _defaultColor,

    this.second = _defaultColor,
    this.second40 = _defaultColor,
    this.second70 = _defaultColor,
  });

  factory CompanyColor.color(){
    return const CompanyColor(
      primary: Color(0xFF4A3D59),
      primary40: Color.fromARGB(40, 74, 61, 89),
      primary70: Color.fromARGB(74, 74, 61, 89),
      second: Color(0xFF64CCB8),
      second40: Color.fromARGB(40, 100, 204, 184),
      second70: Color.fromARGB(70, 100, 204, 184),
    );
  }
}