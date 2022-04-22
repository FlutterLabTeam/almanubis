import 'package:almanubis/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_screen_state.dart';
import 'package:almanubis/features/auth/presentation/bloc/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/components/input/custom_input.dart';
import '../../../../injection_container.dart';

class AuthNewScreen extends BaseScreen<AuthScreenState, AuthCubit> {
  @override
  Widget buildScreen(
      BuildContext context, AuthCubit bloc, AuthScreenState state) {
    if (state.isLoading) {
      return Lottie();
    }

    return Column(
      children: [
        CustomInput(model: state.userInputModel),
        (state.isLoading) ? 
        ElevatedButton(
          onPressed: () => bloc.login('', ''),
          child: Text("Login"),
        ) :
        Lottie();
      ],
    );
  }

  @override
  AuthCubit createBloc() => sl<AuthCubit>()..load();
}
