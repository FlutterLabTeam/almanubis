import 'package:flutter/material.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/company_colors.dart';

class HeaderChatModel {
  final String title;
  final String image;
  final String description;
  final Function() handledMenu;
  final Function()? handledGoBack;

  HeaderChatModel({
    required this.title,
    required this.image,
    required this.description,
    required this.handledMenu,
    this.handledGoBack,
  });
}

class HeaderChat extends StatelessWidget {
  final HeaderChatModel model;
  static late Size size;

  const HeaderChat({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(model.image),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.2,
          color: Colors.black26,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => model.handledGoBack?? Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: CompanyColor.color().third,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: CompanyFontStyle.style().titleLightStyle,
                    ),
                    Text(
                      model.description,
                      style: CompanyFontStyle.style().textCartWhiteStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => model.handledMenu(),
                  icon: Icon(
                    Icons.more_vert,
                    color: CompanyColor.color().third,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
