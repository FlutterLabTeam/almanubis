import 'package:almanubis/core/components/body/custom_body.dart';
import 'package:flutter/cupertino.dart';

class BodyAdmin extends StatelessWidget {
  static late Size size;
  final Widget body;

  const BodyAdmin({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return CustomBody(
      model: CustomBodyModel(
        color: ColorCustomBody.dark,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width * 0.45),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/bigLogo.png"))),
            ),
            body
          ],
        ),
      ),
    );
  }
}
