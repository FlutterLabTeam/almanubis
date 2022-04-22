import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseScreen<S, T extends BlocBase<S>> extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  T createBloc();

  initBloc(T bloc) {}

  T getBloc(BuildContext context) => context.read<T>();

  Widget buildScreen(BuildContext context, T bloc, S state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = createBloc();
        initBloc(bloc);
        return bloc;
      },
      child: BlocBuilder<T, S>(
        builder: (context, state) {
          final bloc = getBloc(context);
          return Scaffold(
            body: buildScreen(
              context,
              bloc,
              state,
            ),
          );
        },
      ),
    );
  }
}
