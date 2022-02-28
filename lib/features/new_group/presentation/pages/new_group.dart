import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:almanubis/core/components/carousel_image_user/carousel_image_user.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:almanubis/features/new_group/presentation/bloc/new_group_bloc.dart';
import 'package:almanubis/core/components/selected_item/selected_item.dart';
import 'package:almanubis/core/components/input_search/input_search.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/debouncer.dart';
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
  List<UserModel> listStaticUser = [];
  static final _debouncer = HandledDebouncer(milliseconds: 700);

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
              changeStateState(state);
            }
            if (state is GetAllUserState) {
              getAllUserState(state);
            }
            if (state is GetSearchUserState) {
              getSearchUserState(state);
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
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
                    height: listUserData.isNotEmpty ? size.height * 0.13 : 0,
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
                      model: InputSearchColorModel(
                        label: "Buscar usuario",
                        onChanged: (String text) =>
                            _debouncer.run(() => handledSearch(text)),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: SizedBox(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: size.height * 0.03, bottom: size.height * 0.1, left: 20, right: 20),
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
                ],
              ),
            );
          },
        ),
        floatingActionButton: CustomFloatingButton(
          model: CustomFloatingButtonModel(
            icon: Icons.arrow_forward,
            handledIcon: (){
              if(listUserData.isNotEmpty){
                Navigator.of(context).pushNamed('/saveGroup', arguments: listUserData);
              }else{
                snackBarMessage(
                  context,
                  message: "Es necesario que selecciones usuarios",
                );
              }
            }
          ),
        ),
      ),
    );
  }

  handledSelectedUser(UserModel userModel) =>
      BlocProvider.of<NewGroupBloc>(context)
          .add(ChangeStateEvent(userModel: userModel));

  handledSearch(String text) => BlocProvider.of<NewGroupBloc>(context).add(
        SearchUserEvent(
          userText: text,
          listStaticUserModel: listStaticUser,
        ),
      );

  getAllUserState(GetAllUserState state) {
    state.listUserModel.sort((a, b) => a.name.compareTo(b.name));
    listAllUser = state.listUserModel;
    listStaticUser = state.listUserModel;
  }

  getSearchUserState(GetSearchUserState state) {
    state.listUserModel.sort((a, b) => a.name.compareTo(b.name));
    listAllUser = state.listUserModel.map((elementMap) {
      UserModel user = listUserData.firstWhere(
          (elementFirst) => elementFirst.uid == elementMap.uid,
          orElse: () => UserModel.fromJsonNoData());
      if (user.uid!.isNotEmpty) {
        elementMap = user;
      }
      return elementMap;
    }).toList();
  }

  changeStateState(ChangeStateState state) {
    if(!state.userModel.state!){
      state.userModel.state = true;
      listUserData.add(state.userModel);
    }else{
      state.userModel.state = false;
      listUserData.removeWhere((e)=> e.uid == state.userModel.uid);
    }
    BlocProvider.of<NewGroupBloc>(context).add(NewGroupInitEvent());
  }
}
