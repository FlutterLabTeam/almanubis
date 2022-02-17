import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/cupertino.dart';

class NoData extends StatelessWidget {

  static late Size size;

  const NoData({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Column(
      children: [
        CustomImage(
          model: CustomImageModel(color: CustomImageColor.dark),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          "No hay Datos",
          style: CompanyFontStyle.style().titleStyleDark,
        )
      ],
    );
  }
}
