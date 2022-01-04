import 'package:almanubis/core/components/square_image/square_image.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: SquareImage(
            model: SquareImageModel(
              urlImage:
                  "https://www.caritas.org.mx/wp-content/uploads/2019/02/cualidades-persona-humanitaria.jpg",
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Jeison MAnuel Vargas Vargas",
            style: CompanyFontStyle.style().textCartChatDarkStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 40),
              color: CompanyColor.color().primary,
              child: Icon(
                Icons.check,
                color: CompanyColor.color().third,
              ),
            ))
      ],
    );
  }
}
