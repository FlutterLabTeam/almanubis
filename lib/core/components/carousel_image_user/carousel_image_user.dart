import 'package:almanubis/core/components/image_user_option/image_user_option.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter/material.dart';

enum CarouselColor {
  light,
  dark,
}

class CarouselImageUserModel {
  final Function(UserModel) handledIcon;
  final List<UserModel> listUserData;
  final CarouselColor color;

  CarouselImageUserModel({
    required this.handledIcon,
    required this.listUserData,
    this.color = CarouselColor.light,
  });
}

class CarouselImageUser extends StatelessWidget {

  final CarouselImageUserModel model;

  const CarouselImageUser({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: model.listUserData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ImageUserOption(
              model: ImageUserOptionModel(
                image: model.listUserData[index].image??noImage,
                icon: Icons.clear,
                color: handledGenerateBackColor(model.color),
                handledIcon: () => model.handledIcon(model.listUserData[index]),
              ),
            ),
          );
        });
  }

  ImageUserOptionColor handledGenerateBackColor(CarouselColor carouselColor) {
    switch (carouselColor) {
      case CarouselColor.light:
        return ImageUserOptionColor.light;
      case CarouselColor.dark:
        return ImageUserOptionColor.dark;
    }
  }
}
