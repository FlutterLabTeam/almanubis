import 'package:flutter/material.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';

class ListChat extends StatefulWidget {
  const ListChat({Key? key}) : super(key: key);

  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  static late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                model: CustomAppBarModel(
                  disableGoBack: true,
                  height: size.height * 0.18,
                  elevation: ElevationCount.E12,
                  body: SizedBox(
                    height: size.height * 0.12,
                    width: double.infinity,
                    child: CustomImage(
                      model: CustomImageModel(color: CustomImageColor.dark),
                    ),
                  ),
                  handledGoBack: () {},
                ),
              ),

            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(
          model: CustomNavigationBarModel(),
        ),
      ),
    );
  }
}
