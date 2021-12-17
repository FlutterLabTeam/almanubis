import 'package:flutter/material.dart';

class PaintStart extends StatelessWidget {
  const PaintStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MyRadioProgress(),
    );
  }
}



class _MyRadioProgress extends CustomPainter {


  _MyRadioProgress();

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width *  0.6, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width*0.7, size.height * 0.47);
    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.5, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width * 0.3, size.height*0.7);
    path.lineTo(0, size.height*0.7);
    path.lineTo(size.width * 0.3, size.height*0.47);
    path.lineTo(0, size.height*0.2);
    path.lineTo(size.width * 0.4, size.height*0.3);
    path.lineTo(size.width * 0.5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
