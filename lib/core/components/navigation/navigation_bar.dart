import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum CustomNavigationBarColors {
  black,
  white,
}

class CustomNavigationBarModel {
  final CustomNavigationBarColors color;

  CustomNavigationBarModel({
    this.color = CustomNavigationBarColors.black,
  });
}

class CustomNavigationBar extends StatelessWidget {
  final void Function()? onTapMessage;
  final void Function()? onTapPerson;
  final void Function()? onTapPlus;
  final CustomNavigationBarModel model;

  const CustomNavigationBar({
    Key? key,
    required this.model,
    this.onTapMessage,
    this.onTapPerson,
    this.onTapPlus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CompanyColor.color().primary,
        boxShadow: const [
          BoxShadow(
            /*color: _getColor(model.color),*/
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.message_rounded,
                color: CompanyColor.color().third,
                /*color: CompanyColor.color().primary,*/
                size: 25,
              ),
              onPressed: onTapMessage,
            ),
          ),
          if (onTapPlus != null)
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.add_rounded,
                  size: 35,
                  color: CompanyColor.color().second,
                ),
                onPressed: onTapPlus,
              ),
            ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: CompanyColor.color().third,
                size: 25,
              ),
              onPressed: onTapPerson,
            ),
          ),
        ],
      ),
    );
  }

/*  Color _getColor(CustomNavigationBarColors color) {
    switch (color) {
      case CustomNavigationBarColors.black:
        return Colors.black;
      case CustomNavigationBarColors.white:
        return Colors.white;
      default:
        return Colors.black;
    }
  }*/
}
