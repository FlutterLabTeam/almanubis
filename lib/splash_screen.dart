import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/components/image/custom_image.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).add(ValidateUserLoggedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        if (state is NoExistCredentialErrorState) {
          Navigator.pushReplacementNamed(context, "/authPage");
        }
        if (state is ExistCredentialState) {
          BlocProvider.of<AuthBloc>(context).add(
            LoginEvent(
              email: state.dataCredential.email,
              password: state.dataCredential.password,
            ),
          );
        }
        if (state is GetUserDataLoadedState) {
          handledGoHome(state.userModel);
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomImage(
              model: CustomImageModel(color: CustomImageColor.dark),
            ),
          ),
        ),
      ),
    );
  }

  handledGoHome(UserModel userModel) {
    Navigator.pushReplacementNamed(context, "/home", arguments: userModel);
  }
}
