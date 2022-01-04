import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

class ImageUser extends StatelessWidget {
  static late Size size;
  final String? image;

  const ImageUser({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: size.width * 0.4,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: CompanyColor.color().primary70,
                spreadRadius: 9,
                blurRadius: 9,
              )
            ],
            color: CompanyColor.color().primary,
            image: image != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image!,
                    ),
                  )
                : null,
            border: Border.all(
              width: 4,
              color: CompanyColor.color().primary,
            ),
          ),
          child: Icon(
            Icons.people_outline_rounded,
            size: 100,
            color: CompanyColor.color().third,
          ),
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
            onPressed: () {},
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
}
