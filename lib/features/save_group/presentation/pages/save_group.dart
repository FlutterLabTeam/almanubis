import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/util/generate_query.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:almanubis/features/save_group/presentation/bloc/save_group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/image_user_option/image_user_option.dart';
import 'package:almanubis/core/components/input_edit_account/input_edit_account.dart';
import 'package:almanubis/features/user_configuration/presentation/widgets/image_user.dart';
import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';

class SaveGroup extends StatefulWidget {
  final List<UserModel> listUser;

  const SaveGroup({
    Key? key,
    required this.listUser,
  }) : super(key: key);

  @override
  State<SaveGroup> createState() => SaveGroupStateView();
}

class SaveGroupStateView extends State<SaveGroup> {
  static late Size size;
  static late bool loadingButton = false;
  static late GlobalKey<FormState> _formKey;
  static late List<UserModel> listUserModel;
  static late TextEditingController titleGroupController;
  static late TextEditingController descriptionGroupController;

  @override
  void initState() {
    super.initState();
    listUserModel = widget.listUser;
    _formKey = GlobalKey<FormState>();
    titleGroupController = TextEditingController();
    descriptionGroupController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocListener<SaveGroupBloc, SaveGroupState>(
      listener: (context, state) {
        if (state is SaveNewGroupErrorState) {
          snackBarMessage(context, message: "Lo sentimos, ocurrió un error al realizar el guardado de nuevo grupo");
        }
        if (state is SaveNewGroupState) {
          snackBarMessage(context, message: "La operación se realizó con éxito");
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: SafeArea(child: BlocBuilder<SaveGroupBloc, SaveGroupState>(
        builder: (context, state) {
          if (state is ChangeStateState) {
            loadingButton = false;
            listUserModel.map((element) {
              if (element.uid == state.userModel.uid) {
                element.state = !element.state!;
              }
            }).toList();
            listUserModel.removeWhere((element) => element.state == false);
          }
          if (state is SaveNewGroupLoadingState) {
            loadingButton = true;
          }
          return Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppBar(
                    model: CustomAppBarModel(
                      height: 90,
                      body: const Text(""),
                      handledGoBack: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Container(
                    height: size.height * 0.43,
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const ImageUser(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 3),
                            child: InputEditAccount(
                              model: InputEditAccountColorModel(
                                label: "Nombre De Grupo",
                                validator: validationEmpty,
                                controller: titleGroupController,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: InputEditAccount(
                              model: InputEditAccountColorModel(
                                  validator: validationEmpty,
                                  label: "Descripción del grupo",
                                  controller: descriptionGroupController,
                                  typeInput: InputEditAccountType.description),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.35,
                    alignment: Alignment.topLeft,
                    color: CompanyColor.color().primary,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Text(
                              "Participantes",
                              style: CompanyFontStyle.style().titleStyleLight,
                            ),
                          ),
                          GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 4,
                            children: List.generate(
                              listUserModel.length,
                              (index) => ImageUserOption(
                                  model: ImageUserOptionModel(
                                      handledIcon: () => handledSelectedUser(
                                          listUserModel[index]),
                                      icon: Icons.people,
                                      image: listUserModel[index].image ??
                                          noImage)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                loadingButton: loadingButton,
                handledIcon: () => saveNewGroup(),
              ),
            ),
          );
        },
      )),
    );
  }

  dynamic validationEmpty(value) {
    if (value.isEmpty) {
      return 'Este campo no puede ser vacío';
    } else {
      return null;
    }
  }

  handledSelectedUser(UserModel userModel) =>
      BlocProvider.of<SaveGroupBloc>(context)
          .add(ChangeStateEvent(userModel: userModel));

  saveNewGroup() {
    if (_formKey.currentState!.validate()) {
      GroupModel groupModel = GroupModel(
        title: titleGroupController.text,
        description: descriptionGroupController.text,
        listUser: listUserModel,
        query: generateQuery(titleGroupController.text),
        image: "",
        dateCreate: DateTime.now(),
      );

      BlocProvider.of<SaveGroupBloc>(context)
          .add(SaveNewGroupEvent(groupModel: groupModel));
    }
  }
}
