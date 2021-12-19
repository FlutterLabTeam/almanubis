import 'package:almanubis/core/components/start/paint_start.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColorCustomBody {
  light,
  dark,
}

class CustomBodyModel {
  final ColorCustomBody color;
  final Widget body;

  CustomBodyModel({
    required this.color,
    required this.body,
  });
}

class CustomBody extends StatelessWidget {
  final CustomBodyModel model;
  static late Size size;

  const CustomBody({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: _getColor(model.color),
      child: Stack(
        children: [
          Container(
            margin:
                EdgeInsets.only(left: size.width * 0.2, top: size.height * 0.1),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.8, top: size.height * 0.15),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color), size: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.1, top: size.height * 0.32),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color), size: 15),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.7),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color), size: 15),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: size.width * 0.8, top: size.height * 0.8),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color), size: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.3, top: size.height * 0.85),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color)),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: size.width * 0.7, top: size.height * 0.9),
            child: PaintStart(
              model: PaintStartModel(color: _getColorStar(model.color)),
            ),
          ),
          model.body,
        ],
      ),
    );
  }

  Color _getColor(ColorCustomBody color) {
    switch (color) {
      case ColorCustomBody.light:
        return CompanyColor.color().second;
      case ColorCustomBody.dark:
        return CompanyColor.color().primary;
    }
  }

  colorStar _getColorStar(ColorCustomBody color) {
    switch (color) {
      case ColorCustomBody.light:
        return colorStar.dark;
      case ColorCustomBody.dark:
        return colorStar.light;
    }
  }
}
