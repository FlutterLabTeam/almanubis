import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/bloc/global_bloc.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:almanubis/core/components/body/custom_body.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/core/components/input_edit_account/input_edit_account.dart';
import 'package:almanubis/features/user_configuration/presentation/widgets/image_user.dart';
import 'package:almanubis/core/components/custom_floating_button/custom_floating_button.dart';
import 'package:almanubis/features/user_configuration/presentation/bloc/user_configuration_bloc.dart';

class UserConfiguration extends StatefulWidget {
  final UserModel userModel;

  const UserConfiguration({Key? key, required this.userModel})
      : super(key: key);

  @override
  _UserConfigurationState createState() => _UserConfigurationState();
}

class _UserConfigurationState extends State<UserConfiguration> {
  static late Size size;
  static late String path = "";
  static late bool isPath = false;
  static late bool loadingButton = false;
  static late GlobalKey<FormState> _formKey;
  static late TextEditingController nameController = TextEditingController();
  static late TextEditingController descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    nameController.text = widget.userModel.name;
    descriptionController.text = widget.userModel.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocListener<UserConfigurationBloc, UserConfigurationState>(
      listener: (context, state) {
        if (state is UpdateUserErrorState) {
          snackBarMessage(context,
              message:
                  "Lo sentimos, ocurrió un error al realizar la operación");
        }
        if (state is UpdateUserState) {
          path = "";
          isPath = false;
          snackBarMessage(context,
              message: "La operación se realizó con éxito");
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<UserConfigurationBloc, UserConfigurationState>(
        builder: (context, state) {
          loadingButton = false;
          if (state is UpdateUserLoadingState) {
            loadingButton = true;
          }
          return BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              if (state is TakeImageState) {
                path = state.path;
                isPath = true;
              }
              if (state is SaveImageState) {
                BlocProvider.of<GlobalBloc>(context).add(DisposeEvent());
                updateUser(state.link);
              }
              return Scaffold(
                body: CustomBody(
                  model: CustomBodyModel(
                      body: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width,
                            ),
                            ImageUser(
                              image: isPath ? path : widget.userModel.image,
                              typeImage: isPath
                                  ? TypeImage.fileType
                                  : TypeImage.networkType,
                              handledTakeImage: () => handledTakeImage(),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02,
                                    horizontal: size.width * 0.02),
                                child: InputEditAccount(
                                  model: InputEditAccountModel(
                                    label: "Nombre de Usuario",
                                    controller: nameController,
                                    validator: validationEmpty,
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: InputEditAccount(
                                model: InputEditAccountModel(
                                    label: "Descripción",
                                    validator: validationEmpty,
                                    controller: descriptionController,
                                    typeInput:
                                        InputEditAccountType.description),
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: ColorCustomBody.light),
                ),
                floatingActionButton: CustomFloatingButton(
                  model: CustomFloatingButtonModel(
                    icon: Icons.arrow_forward,
                    loadingButton: loadingButton,
                    handledIcon: () => saveImage(),
                  ),
                ),
                bottomNavigationBar: CustomNavigationBar(
                  onTapMessage: () => Navigator.of(context)
                      .pushReplacementNamed('/listChat',
                          arguments: widget.userModel),
                  model: CustomNavigationBarModel(
                    color: CustomNavigationBarColors.black,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  dynamic validationEmpty(value) {
    if (value.isEmpty) {
      return 'Este campo no puede ser vacío';
    } else {
      return null;
    }
  }

  handledTakeImage() => BlocProvider.of<GlobalBloc>(context).add(
        TakeImageEvent(
          imageQualityModel: ImageQualityModel(
            size: ImageSizeEnum.l,
            imageQuality: 70
          ),
        ),
      );

  saveImage() {
    if (_formKey.currentState!.validate()) {
      loadingButton = true;
      if (widget.userModel.image != null) {
        BlocProvider.of<GlobalBloc>(context).add(
          UpdateImageEvent(
            path: path,
            folderDB: "user_image",
            idUser: widget.userModel.uid,
            link: widget.userModel.image!,
          ),
        );
      } else {
        BlocProvider.of<GlobalBloc>(context).add(
          SaveImageEvent(
            path: path,
            folderDB: "user_image",
            idUser: widget.userModel.uid,
          ),
        );
      }
    }
  }

  updateUser(String link) {
    widget.userModel.name = nameController.text;
    widget.userModel.description = descriptionController.text;
    widget.userModel.dateUpdate = DateTime.now();
    widget.userModel.image = link;

    BlocProvider.of<UserConfigurationBloc>(context)
        .add(UpdateUserEvent(userModel: widget.userModel));
  }
}
