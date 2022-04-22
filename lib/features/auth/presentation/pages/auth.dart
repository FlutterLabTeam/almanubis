import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:almanubis/core/components/body/custom_body.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/core/components/input/custom_input.dart';
import 'package:almanubis/core/components/button/custom_button.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static late Size size;
  static late bool statePassword = true;
  static late bool buttonLoading = false;
  static late TextEditingController emailController;
  static late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          snackBarMessage(
            context,
            message: "Lo sentimos, usuario o contraseña incorrecto",
          );
          emailController.text = "";
          passwordController.text = "";
        }
        if (state is GetUserDataErrorState) {
          snackBarMessage(
            context,
            message:
                "Lo sentimos, hubo un erro al traer los datos, comunícate con información",
          );
        }
        if (state is GetUserDataLoadedState) {
          handledGoHome(state.userModel);
        }
      },
      child: Scaffold(
          body: CustomBody(
        model: CustomBodyModel(
          color: ColorCustomBody.dark,
          body: SingleChildScrollView(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                buttonLoading = false;
                if (state is ChangePasswordState) {
                  statePassword = state.state;
                }
                if (state is LoginLoadingState) {
                  buttonLoading = true;
                }
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.17,
                        margin: EdgeInsets.only(top: size.height * 0.13),
                        width: double.infinity,
                        child: CustomImage(
                          model:
                              CustomImageModel(color: CustomImageColor.light),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.04),
                        child: Text(
                          "almanubis",
                          style: CompanyFontStyle.style().titleAppLight,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * 0.1,
                          bottom: size.height * 0.02,
                          right: size.width * 0.12,
                          left: size.width * 0.12,
                        ),
                        child: CustomInput(
                          model: CustomInputColorModel(
                              label: "Usuario", controller: emailController),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.12),
                        child: CustomInput(
                          model: CustomInputColorModel(
                            label: "Contraseña",
                            isObscure: statePassword,
                            controller: passwordController,
                            typeInput: CustomInputType.password,
                            tapIcon: () => BlocProvider.of<AuthBloc>(context)
                                .add(
                                    ChangePasswordEvent(state: !statePassword)),
                          ),
                        ),
                      ),
                      buttonLoading
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.08,
                              ),
                              child: const CustomCircularProgressIndicator(),
                            )
                          : Container(
                              height: size.height * 0.085,
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.12,
                                vertical: size.height * 0.08,
                              ),
                              child: CustomButton(
                                model: CustomButtonModel(
                                  label: "Entrar",
                                  handledButton: () => handledLogin(),
                                  color: CustomButtonColor.dark,
                                ),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Solicita el acceso a ",
                            style: TextStyle(
                                color: CompanyColor.color().third,
                                fontSize: 12),
                          ),
                          GestureDetector(
                            child: Text(
                              "Info@almanubis.com",
                              style: TextStyle(
                                  color: CompanyColor.color().second,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )
                    ]);
              },
            ),
          ),
        ),
      )),
    );
  }

  handledLogin() {
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
      email: emailController.text,
      password: passwordController.text,
    ));
  }

  handledGoHome(UserModel userModel) {
    Navigator.pushReplacementNamed(context, "/home", arguments: userModel);
  }
}
