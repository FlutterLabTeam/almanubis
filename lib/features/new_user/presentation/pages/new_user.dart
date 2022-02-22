import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:almanubis/features/new_user/presentation/bloc/new_user_bloc.dart';
import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/core/components/appbar/custom_appbar.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/input/custom_input.dart';
import 'package:almanubis/core/util/generate_query.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/constant.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  static late Size size;
  static late bool loadingButton = false;
  static late EdgeInsets marginGlobal;
  static late bool statePassword = true;
  static late bool stateRepeatPassword = true;
  static late TextEditingController userController;
  static late TextEditingController emailController;
  static late TextEditingController passwordController;
  static late TextEditingController repeatPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    marginGlobal = EdgeInsets.only(
      top: size.height * 0.02,
      left: size.width * 0.12,
      right: size.width * 0.12,
      bottom: size.height * 0.02,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewUserBloc, NewUserState>(
      listener: (context, state) {
        if (state is NewUserRegisterFailure) {
          snackBarMessage(
            context,
            message: "Lo sentimos, este correo ya existe",
          );
          emailController.text = "";
        }
        if (state is RegisterUserDbFailure) {
          snackBarMessage(
            context,
            message: "Lo sentimos, hubo un error al guardar en base de datos",
          );
        }
        if (state is RegisterUserDbLoaded) {
          snackBarMessage(
            context,
            message: "Se realizó el registro correctamente",
          );
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocBuilder<NewUserBloc, NewUserState>(
                builder: (context, state) {
                  loadingButton = false;
                  if (state is ChangePasswordState) {
                    statePassword = state.state;
                  }
                  if (state is ChangeRepeatPasswordState) {
                    stateRepeatPassword = state.state;
                  }
                  if (state is NewUserRegisterLoading) {
                    loadingButton = true;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAppBar(
                        model: CustomAppBarModel(
                          body: Text(
                            "NUEVO USUARIO",
                            style: CompanyFontStyle.style().titleStyleDark,
                          ),
                          handledGoBack: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Container(
                        height: size.height * 0.17,
                        margin: EdgeInsets.only(
                          top: size.height * 0.02,
                          bottom: size.height * 0.02,
                        ),
                        width: double.infinity,
                        child: CustomImage(
                          model: CustomImageModel(color: CustomImageColor.dark),
                        ),
                      ),
                      Container(
                        margin: marginGlobal,
                        child: CustomInput(
                          model: CustomInputColorModel(
                            label: "Usuario",
                            controller: userController,
                            color: CustomInputColor.dark,
                          ),
                        ),
                      ),
                      Container(
                        margin: marginGlobal,
                        child: CustomInput(
                          model: CustomInputColorModel(
                            validator: validationEmail,
                            label: "Correo electronico",
                            controller: emailController,
                            color: CustomInputColor.dark,
                          ),
                        ),
                      ),
                      Container(
                        margin: marginGlobal,
                        child: CustomInput(
                          model: CustomInputColorModel(
                            label: "Contraseña",
                            isObscure: statePassword,
                            color: CustomInputColor.dark,
                            validator: validationPassword,
                            tapIcon: () => BlocProvider.of<NewUserBloc>(context)
                                .add(
                                    ChangePasswordEvent(state: !statePassword)),
                            controller: passwordController,
                            typeInput: CustomInputType.password,
                          ),
                        ),
                      ),
                      Container(
                        margin: marginGlobal,
                        child: CustomInput(
                          model: CustomInputColorModel(
                            label: "Repita la Contraseña",
                            color: CustomInputColor.dark,
                            validator: validationPassword,
                            isObscure: stateRepeatPassword,
                            tapIcon: () => BlocProvider.of<NewUserBloc>(context)
                                .add(ChangeRepeatPasswordEvent(
                                    state: !stateRepeatPassword)),
                            controller: repeatPasswordController,
                            typeInput: CustomInputType.password,
                          ),
                        ),
                      ),
                      loadingButton
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                              ),
                              child: const CustomCircularProgressIndicator(),
                            )
                          : Container(
                              height: size.height * 0.085,
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.12,
                                vertical: size.height * 0.02,
                              ),
                              child: CustomButton(
                                model: CustomButtonModel(
                                  label: "CREAR USUARIO",
                                  color: CustomButtonColor.dark,
                                  handledButton: () => handledRegisterUser(),
                                ),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic validationEmail(value) {
    if (value.isEmpty) {
      return 'Este campo no puede ser vacío';
    } else if (!Validation().emailValidation(value)) {
      return 'Formato incorrecto';
    } else {
      return null;
    }
  }

  dynamic validationPassword(value) {
    if (value.isEmpty) {
      return 'Este campo no puede ser vacío';
    } else if (value.length < 9) {
      return 'Este campo debe tener más de 8 dígitos';
    } else {
      return null;
    }
  }

  dynamic validationRepeatPassword(value) {
    if (value.isEmpty) {
      return 'Este campo no puede ser vacío';
    }
    if (value.isEmpty == passwordController.text) {
      return 'Este campo no puede ser vacío';
    } else if (value.length < 9) {
      return 'Este campo debe tener más de 8 dígitos';
    } else {
      return null;
    }
  }

  handledRegisterUser() {
    if (_formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
        rol: userConstant,
        name: userController.text,
        dateCreate: DateTime.now(),
        email: emailController.text,
        query: generateQuery("${userController.text} ${emailController.text}"),
      );

      BlocProvider.of<NewUserBloc>(context).add(
        RegisterEmailEvent(
          userModel: userModel,
          password: passwordController.text,
        ),
      );
    }
  }
}
