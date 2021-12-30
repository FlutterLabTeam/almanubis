import 'package:flutter/cupertino.dart';

class SquareImageModel {
  final String urlImage;
  final double? size;

  SquareImageModel({
    required this.urlImage,
    this.size = 50,
  });
}

class SquareImage extends StatelessWidget {
  final SquareImageModel model;

  const SquareImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: model.size,
      width: model.size,
      child: Image.network(
        model.urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
