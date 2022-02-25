import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CartChatColor {
  light,
  dark,
}

class CartChatModel {
  final String textChat;
  final CartChatColor? color;

  CartChatModel({
    this.color = CartChatColor.light,
    required this.textChat,
  });
}

class CartChat extends StatelessWidget {
  final Size size;
  final CartChatModel model;

  const CartChat({Key? key, required this.size, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        model.color! == CartChatColor.dark
            ? Expanded(
                flex: 0,
                child: SizedBox(
                  width: size.height * 0.02,
                  height: size.height * 0.02,
                  child: CustomPaint(
                    painter: _MyCheck(_getColor(model.color!)),
                  ),
                ),
              )
            : Container(),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.015,
            ),
            color: _getColor(model.color!),
            child: Text(
              model.textChat,
              style: model.color == CartChatColor.light
                  ? CompanyFontStyle.style().textCartChatDarkStyle
                  : CompanyFontStyle.style().textCartChatWhiteStyle,
            ),
          ),
        ),
        model.color! == CartChatColor.light
            ? Expanded(
                flex: 0,
                child: SizedBox(
                  width: size.height * 0.02,
                  height: size.height * 0.02,
                  child: CustomPaint(
                    painter: _MyLightCheck(_getColor(model.color!)),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Color _getColor(CartChatColor color) {
    switch (color) {
      case CartChatColor.light:
        return CompanyColor.color().second;
      case CartChatColor.dark:
        return CompanyColor.color().primary;
    }
  }
}

class _MyCheck extends CustomPainter {
  final Color color;

  _MyCheck(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MyLightCheck extends CustomPainter {
  final Color color;

  _MyLightCheck(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
