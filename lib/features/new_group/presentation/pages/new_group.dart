import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:almanubis/core/components/carousel_image_user/carousel_image_user.dart';
import 'package:almanubis/core/components/selected_item/selected_item.dart';
import 'package:almanubis/core/components/input_search/input_search.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:flutter/material.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  /*static late Size size;*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  size = MediaQuery.of(context).size;*/
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              model: CustomAppBarModel(
                body: Text(
                  "NUEVO GRUPO",
                  style: CompanyFontStyle.style().titleStyleDark,
                ),
                handledGoBack: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: CarouselImageUser(
                model: CarouselImageUserModel(
                  handledIcon: () {},
                  color: CarouselColor.dark,
                  listUserData: [
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                    UserModel(
                        image:
                            "https://fotografias.lasexta.com/clipping/cmsimages01/2021/06/02/45663211-B024-4F6F-A4C7-4859DA27CE25/98.jpg",
                        name: "Jeison",
                        email: "",
                        dateCreate: DateTime.now(),
                        query: [],
                        rol: ""),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InputSearch(
                model: InputSearchColorModel(label: "Buscar usuario"),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: SelectedItem()),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          onTapPlus: () {},
          model: CustomNavigationBarModel(),
          onTapMessage: () => Navigator.of(context).pushNamed('/listChat'),
          onTapPerson: () =>
              Navigator.of(context).pushNamed('/userConfiguration'),
        ),
        floatingActionButton: CustomFloatingButton(
          model: CustomFloatingButtonModel(
            icon: Icons.arrow_forward,
            handledIcon: () => Navigator.of(context).pushNamed('/saveGroup'),
          ),
        ),
      ),
    );
  }
}
