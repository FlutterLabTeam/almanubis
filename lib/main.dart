import 'package:firebase_core/firebase_core.dart';

import 'core/bloc/global_bloc.dart';
import 'features/add_new_group/presentation/bloc/add_new_user_bloc.dart';
import 'features/information_panel_groups/presentation/bloc/information_panel_bloc.dart';
import 'features/list_chat/presentation/bloc/list_chat_bloc.dart';
import 'features/new_group/presentation/bloc/new_group_bloc.dart';
import 'features/save_group/presentation/bloc/save_group_bloc.dart';
import 'features/user_configuration/presentation/bloc/user_configuration_bloc.dart';
import 'injection_container.dart';
import 'package:almanubis/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/new_user/presentation/bloc/new_user_bloc.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<GlobalBloc>()),
          BlocProvider(create: (context) => sl<NewUserBloc>()),
          BlocProvider(create: (context) => sl<ListChatBloc>()),
          BlocProvider(create: (context) => sl<NewGroupBloc>()),
          BlocProvider(create: (context) => sl<SaveGroupBloc>()),
          BlocProvider(create: (context) => sl<AddNewUserBloc>()),
          BlocProvider(create: (context) => sl<UserConfigurationBloc>()),
          BlocProvider(create: (context) => sl<InformationPanelBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Almanubis',
          theme: ThemeData(
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white),
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
