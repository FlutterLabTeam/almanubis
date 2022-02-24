import 'dart:io';

import 'package:almanubis/core/util/company_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum TypeImage {
  fileType,
  networkType,
  assetType,
}

class ImageUser extends StatelessWidget {
  final String? image;
  static late Size size;
  final TypeImage? typeImage;
  final Function handledTakeImage;

  const ImageUser({
    Key? key,
    this.image,
    this.typeImage = TypeImage.networkType,
    required this.handledTakeImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: size.width * 0.43,
          width: size.width * 0.43,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: CompanyColor.color().primary70,
                spreadRadius: 9,
                blurRadius: 9,
              )
            ],
            color: CompanyColor.color().primary,
            border: Border.all(
              width: 4,
              color: CompanyColor.color().primary,
            ),
          ),
          child: image == null || image!.isEmpty
              ? Icon(
                  Icons.people_outline_rounded,
                  size: size.height * 0.15,
                  color: CompanyColor.color().third,
                )
              : handledGenderImage(typeImage: typeImage!, path: image!),
        ),
        Container(
          height: size.height * 0.05,
          width: size.width * 0.1,
          decoration: BoxDecoration(
            color: CompanyColor.color().second,
            boxShadow: [
              BoxShadow(
                color: CompanyColor.color().primary70,
                spreadRadius: 2,
                blurRadius: 2,
              )
            ],
          ),
          child: IconButton(
            onPressed: () => handledTakeImage(),
            icon: Icon(
              Icons.edit,
              color: CompanyColor.color().primary,
              size: 20,
            ),
          ),
        )
      ],
    );
  }

  handledGenderImage({required TypeImage typeImage, required String path}) {
    switch (typeImage) {
      case TypeImage.fileType:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(
                File(path),
              ),
            ),
          ),
        );
      case TypeImage.networkType:
        return CachedNetworkImage(
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: CompanyColor.color().primary,
            highlightColor: CompanyColor.color().second,
            child: Icon(
              Icons.people_outline_rounded,
              size: size.height * 0.15,
              color: CompanyColor.color().third,
            ),
          ),
          imageUrl: image!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(path),
              ),
            ),
          ),
        );
      case TypeImage.assetType:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(path),
            ),
          ),
        );
    }
  }
}
