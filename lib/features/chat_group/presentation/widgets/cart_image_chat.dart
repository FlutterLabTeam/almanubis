import 'dart:io';

import 'package:flutter/material.dart';

class CartImageChat extends StatelessWidget {
  static late Size size;
  final String imagePath;
  final Function(String) handledDeleteImage;

  const CartImageChat({
    Key? key,
    required this.imagePath,
    required this.handledDeleteImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
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
                File(imagePath),
              ),
            )
          ),
        ),
        GestureDetector(
          onTap: () => handledDeleteImage(imagePath),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close),
          ),
        )
      ],
    );
  }
}
