import 'dart:io';

import 'package:flutter/cupertino.dart';

class CartImageInputPresentation extends StatelessWidget {

  final String pathImage;
  final Size size;

  const CartImageInputPresentation({Key? key, required this.pathImage, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.01,
      ),
      width: size.height * 0.09,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              File(pathImage),
            ),
          )),
    );
  }
}
