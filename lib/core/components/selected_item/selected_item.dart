import 'package:almanubis/core/components/square_image/square_image.dart';
import 'package:almanubis/core/constant.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  final UserModel userModel;
  final Function(UserModel) handledSelectedUser;

  const SelectedItem({
    Key? key,
    required this.userModel,
    required this.handledSelectedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => handledSelectedUser(userModel),
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: SquareImage(
                model: SquareImageModel(
                  urlImage: userModel.image ?? noImage,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  userModel.name,
                  style: CompanyFontStyle.style().textCartChatDarkStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.only(left: 40),
                  decoration: BoxDecoration(
                    color: userModel.state!
                        ? CompanyColor.color().primary
                        : CompanyColor.color().third,
                    border: Border.all(
                      width: 1.2,
                      color: CompanyColor.color().primary,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: CompanyColor.color().third,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
