import 'package:almanubis/core/util/company_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CompanyColor.color().primary,
          width: 1
        )
      ),
      height: model.size,
      width: model.size,
      child: CachedNetworkImage(
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: CompanyColor.color().primary,
          highlightColor: CompanyColor.color().second,
          child: const Icon(Icons.group, size: 50,),
        ),
        imageUrl: model.urlImage,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
