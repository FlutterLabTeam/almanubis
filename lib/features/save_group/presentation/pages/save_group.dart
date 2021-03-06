import 'package:flutter/material.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/bloc/global_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/generate_query.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/image_user_option/image_user_option.dart';
import 'package:almanubis/core/components/input_edit_account/input_edit_account.dart';
import 'package:almanubis/features/save_group/presentation/bloc/save_group_bloc.dart';
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
  static late String path = "";
  static late bool isPath = false;
  static late double heightHeader;
  static late bool isSubmit = true;
  static late bool loadingButton = false;
  static late GlobalKey<FormState> _formKey;
  static late List<UserModel> listUserModel;
  static late TextEditingController titleGroupController;
  static late TextEditingController descriptionGroupController;

  @override
  void initState() {
    super.initState();
    isSubmit = true;
    listUserModel = widget.listUser;
    heightHeader = 0.40;
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
          snackBarMessage(
            context,
            message:
                "Lo sentimos, ocurri?? un error al realizar el guardado de nuevo grupo",
          );
        }
        if (state is SaveNewGroupState) {
          descriptionGroupController.text = "";
          titleGroupController.text = "";
          loadingButton = false;
          path = "";
          snackBarMessage(
            context,
            message: "La operaci??n se realiz?? con ??xito",
          );
          BlocProvider.of<SaveGroupBloc>(context)
              .add(InitStateSaveGroupEvent());
          BlocProvider.of<GlobalBloc>(context).add(InitStateGlobalEvent());
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
                      height: size.height * 0.12,
                      body: const Text(""),
                      handledGoBack: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Container(
                    height: size.height * heightHeader,
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BlocBuilder<GlobalBloc, GlobalState>(
                            builder: (context, state) {
                              if (state is TakeImageState) {
                                isPath = true;
                                path = state.path;
                              }
                              return ImageUser(
                                typeImage: isPath
                                    ? TypeImage.fileType
                                    : TypeImage.networkType,
                                sizeParams: size.width * 0.30,
                                handledTakeImage: () => handledTakeImage(),
                                image: path,
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 3,
                            ),
                            child: InputEditAccount(
                              model: InputEditAccountModel(
                                label: "Nombre De Grupo",
                                validator: validationEmpty,
                                controller: titleGroupController,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: InputEditAccount(
                              model: InputEditAccountModel(
                                  validator: validationEmpty,
                                  label: "Descripci??n del grupo",
                                  controller: descriptionGroupController,
                                  typeInput: InputEditAccountType.description),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.50,
                    alignment: Alignment.topLeft,
                    color: CompanyColor.color().primary,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Participantes",
                                  style:
                                      CompanyFontStyle.style().titleStyleLight,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: CompanyColor.color().second),
                                child: Text(
                                  listUserModel.length.toString(),
                                  style: CompanyFontStyle.style()
                                      .labelCounterStyle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
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
                                  handledIcon: () =>
                                      handledSelectedUser(listUserModel[index]),
                                  icon: Icons.people,
                                  image: listUserModel[index].image ?? noImage,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                if (state is SaveImageLoadingState) {
                  loadingButton = true;
                }
                if (state is SaveImageState) {
                  saveNewGroup(state.link);
                }
                return CustomFloatingButton(
                  model: CustomFloatingButtonModel(
                    icon: Icons.check,
                    loadingButton: loadingButton,
                    handledIcon: () => loadingButton ? () {} : saveImage(),
                  ),
                );
              },
            ),
          );
        },
      )),
    );
  }

  dynamic validationEmpty(value) {
    if (value.isEmpty) {
      return 'Este campo no puede ser vac??o';
    } else {
      return null;
    }
  }

  handledSelectedUser(UserModel userModel) =>
      BlocProvider.of<SaveGroupBloc>(context)
          .add(ChangeStateEvent(userModel: userModel));

  handledTakeImage() => BlocProvider.of<GlobalBloc>(context).add(TakeImageEvent(
        isPhoto: false,
        imageQualityModel: ImageQualityModel(),
      ));

  saveImage() {
    if (_formKey.currentState!.validate()) {
      if (path.isNotEmpty) {
        BlocProvider.of<GlobalBloc>(context).add(
          SaveImageEvent(
            path: path,
            folderDB: "group_image",
          ),
        );
      } else {
        snackBarMessage(
          context,
          message: "Es necesario que el grupo tenga una foto",
        );
      }
    } else {
      heightHeader = 0.46;
      BlocProvider.of<SaveGroupBloc>(context).add(InitStateSaveGroupEvent());
    }
  }

  saveNewGroup(String link) {
    if (isSubmit) {
      isSubmit = false;
      GroupModel groupModel = GroupModel(
        image: link,
        listUser: listUserModel,
        dateCreate: DateTime.now(),
        title: titleGroupController.text,
        description: descriptionGroupController.text,
        query: generateQuery(titleGroupController.text),
        listUserId: listUserModel.map((e) => e.uid!).toList(),
        listUserNotify: listUserModel.map((e) => e.uid!).toList(),
      );

      BlocProvider.of<SaveGroupBloc>(context)
          .add(SaveNewGroupEvent(groupModel: groupModel));
    }
  }
}
