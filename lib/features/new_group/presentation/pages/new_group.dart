import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:almanubis/core/components/carousel_image_user/carousel_image_user.dart';
import 'package:almanubis/features/new_group/presentation/bloc/new_group_bloc.dart';
import 'package:almanubis/core/components/selected_item/selected_item.dart';
import 'package:almanubis/core/components/input_search/input_search.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  static late Size size;
  List<UserModel> listAllUser = [];
  List<UserModel> listUserData = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewGroupBloc>(context).add(GetAllUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NewGroupBloc, NewGroupState>(
          builder: (context, state) {
            if (state is ChangeStateState) {
              listAllUser.map((element) {
                if (element.uid == state.userModel.uid) {
                  element.state = !element.state!;
                }
              }).toList();
              listUserData = listAllUser
                  .where((element) => element.state == true)
                  .toList();
            }
            if (state is GetAllUserState) {
              state.listUserModel.sort((a,b) => a.name.compareTo(b.name));
              listAllUser = state.listUserModel;
            }
            return Column(
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
                  height: listUserData.isNotEmpty ? size.height * 0.12 : 0,
                  width: double.infinity,
                  child: CarouselImageUser(
                    model: CarouselImageUserModel(
                      color: CarouselColor.dark,
                      listUserData: listUserData,
                      handledIcon: handledSelectedUser,
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
                        itemCount: listAllUser.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: SelectedItem(
                            userModel: listAllUser[index],
                            handledSelectedUser: handledSelectedUser,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: CustomNavigationBar(
          onTapPlus: () {},
          model: CustomNavigationBarModel(),
          onTapMessage: () => Navigator.of(context).pushNamed('/listChat'),
          onTapPerson: () => Navigator.of(context).pushNamed('/userConfiguration'),
        ),
        floatingActionButton: CustomFloatingButton(
          model: CustomFloatingButtonModel(
            icon: Icons.arrow_forward,
            handledIcon: () => Navigator.of(context).pushNamed('/saveGroup', arguments: listUserData),
          ),
        ),
      ),
    );
  }

  handledSelectedUser(UserModel userModel) => BlocProvider.of<NewGroupBloc>(context).add(ChangeStateEvent(userModel: userModel));
}
