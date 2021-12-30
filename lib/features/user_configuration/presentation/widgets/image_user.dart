import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageUser extends StatelessWidget {
  static late Size size;

  const ImageUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: size.height * 0.25,
          width: size.width * 0.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: CompanyColor.color().primary70,
                spreadRadius: 9,
                blurRadius: 9,
              )
            ],
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://laboratoriosniam.com/wp-content/uploads/2018/07/michael-dam-258165-unsplash_WEB2.jpg")),
            border: Border.all(
              width: 4,
              color: CompanyColor.color().primary,
            ),
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
