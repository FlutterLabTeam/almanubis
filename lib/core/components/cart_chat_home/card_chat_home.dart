import 'package:almanubis/core/components/square_image/square_image.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/date_format.dart';
import 'package:flutter/cupertino.dart';

class CardChatHomeModel {
  final int counter;
  final String title;
  final String imageUrl;
  final DateTime dateTime;
  final String description;

  CardChatHomeModel({
    required this.title,
    required this.counter,
    required this.dateTime,
    required this.imageUrl,
    required this.description,
  });
}

class CardChatHome extends StatelessWidget {
  final CardChatHomeModel model;

  const CardChatHome({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.of(context).pushNamed('/chatGroup'),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: SquareImage(
                  model: SquareImageModel(urlImage: model.imageUrl, size: 60),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: CompanyFontStyle.style().titleStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        model.description,
                        style: CompanyFontStyle.style().textCartDarkStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      dateFormatHour(model.dateTime),
                      style: CompanyFontStyle.style().textCartDarkStyle,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(color: CompanyColor.color().second),
                      child: Text(
                        model.counter.toString(),
                        style: CompanyFontStyle.style().labelCounterStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
