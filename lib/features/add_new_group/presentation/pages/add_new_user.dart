import 'package:almanubis/core/model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/util/debouncer.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/input_search/input_search.dart';
import 'package:almanubis/core/components/selected_item/selected_item.dart';
import 'package:almanubis/core/components/carousel_image_user/carousel_image_user.dart';
import 'package:almanubis/features/add_new_group/presentation/bloc/add_new_user_bloc.dart';
import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';

class AddNewUser extends StatefulWidget {

  final GroupModel model;

  const AddNewUser({Key? key, required this.model}) : super(key: key);

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  static late Size size;
  List<UserModel> listAllUser = [];
  List<UserModel> listUserData = [];
  List<UserModel> listStaticUser = [];
  static final _debouncer = HandledDebouncer(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddNewUserBloc>(context).add(GetAllUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AddNewUserBloc, AddNewUserState>(
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  model: CustomAppBarModel(
                    body: Text(
                      "AÑADIR A GRUPOS",
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
          onTapMessage: () => Navigator.of(context).pushReplacementNamed('/listChat'),
          onTapPerson: () =>
              Navigator.of(context).pushReplacementNamed('/userConfiguration'),
        ),
        floatingActionButton: CustomFloatingButton(
          model: CustomFloatingButtonModel(
            icon: Icons.check,
            handledIcon: () => handledAddNewUser()
          ),
        ),
      ),
    );
  }

  handledSelectedUser(UserModel userModel) =>
      BlocProvider.of<AddNewUserBloc>(context)
          .add(ChangeStateEvent(userModel: userModel));

  handledSearch(String text) => BlocProvider.of<AddNewUserBloc>(context).add(
        SearchUserEvent(
          userText: text,
          listStaticUserModel: listStaticUser,
        ),
      );

  handledAddNewUser() =>
      BlocProvider.of<AddNewUserBloc>(context).add(
        AddNewUserDataEvent(
          idGroup: widget.model.id!,
          userModel: listUserData,
        ),
      );

  getAllUserState(GetAllUserState state) {
    state.listUserModel.sort((a, b) => a.name.compareTo(b.name));
    listAllUser = state.listUserModel;
    listStaticUser = state.listUserModel;
    handledSelectedUserPreLoading();
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
    BlocProvider.of<AddNewUserBloc>(context).add(AddNewUserInitEvent());
  }

  handledSelectedUserPreLoading(){
    listUserData = widget.model.listUser;
    listUserData.map((e) => e.state = true).toList();
    listUserData.forEach((element) {
      listAllUser.map((e) {
        if(e.uid == element.uid){
          e.state = true;
        }
       return e;
      }).toList();
    });
    BlocProvider.of<AddNewUserBloc>(context).add(AddNewUserInitEvent());
  }
}
