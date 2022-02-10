import 'dart:io';

import 'package:flutter/cupertino.dart';

class PresentationImageAssets extends StatelessWidget {
  final Size size;
  final String urlAssets;

  const PresentationImageAssets({
    Key? key,
    required this.size,
    required this.urlAssets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(
            File(urlAssets),
          ),
        ),
      ),
      height: size.height * 0.3,
      width: size.width * 0.4,
    );
  }
}
