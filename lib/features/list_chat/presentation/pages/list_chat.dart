import 'package:flutter/material.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/cart_chat_home/card_chat_home.dart';

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
    DateTime dateTime = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: Column(
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
            SizedBox(
              height: size.height * 0.7115,
              child: ListView.builder(
                  itemCount: 100,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CardChatHome(
                        model: CardChatHomeModel(
                          title: "Reiki Usui",
                          dateTime: dateTime,
                          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed purus eget consectetur adipiscing elit",
                          counter: 3,
                          imageUrl: "https://laboratoriosniam.com/wp-content/uploads/2018/07/michael-dam-258165-unsplash_WEB2.jpg",
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          model: CustomNavigationBarModel(),
          onTapMessage: () => Navigator.of(context).pushNamed('/listChat'),
          onTapPerson: ()=> Navigator.of(context).pushNamed('/userConfiguration'),
        ),
      ),
    );
  }
}