import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum colorStar {
  light,
  dark,
}

class PaintStartModel {
  final colorStar color;
  final double size;

  PaintStartModel({this.color = colorStar.light, this.size = 10});
}

class PaintStart extends StatelessWidget {
  final PaintStartModel model;

  const PaintStart({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: model.size,
      height: model.size,
      child: CustomPaint(
        painter: _MyRadioProgress(_getColor(model.color)),
      ),
    );
  }

  Color _getColor(colorStar color) {
    switch (color) {
      case colorStar.light:
        return CompanyColor.color().second;
      case colorStar.dark:
        return CompanyColor.color().primary;
    }
  }
}

class _MyRadioProgress extends CustomPainter {
  final Color color;

  _MyRadioProgress(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width * 0.7, size.height * 0.47);
    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.5, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width * 0.3, size.height * 0.7);
    path.lineTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.3, size.height * 0.47);
    path.lineTo(0, size.height * 0.2);
    path.lineTo(size.width * 0.4, size.height * 0.3);
    path.lineTo(size.width * 0.5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
