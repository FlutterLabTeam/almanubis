import 'package:almanubis/core/components/image_user/image_user.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:flutter/material.dart';

class CarouselImageUser extends StatelessWidget {
  final Function handledIcon;
  final List<UserModel> listUserData;

  const CarouselImageUser(
      {Key? key, required this.listUserData, required this.handledIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listUserData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ImageUser(
              model: ImageUserModel(
                image: listUserData[index].image,
                icon: Icons.clear,
                handledIcon: ()=> handledIcon,
              ),
            ),
          );
        });
  }
}
