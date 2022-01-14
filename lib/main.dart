import 'package:firebase_core/firebase_core.dart';

import 'features/new_group/presentation/bloc/new_group_bloc.dart';
import 'features/save_group/presentation/bloc/save_group_bloc.dart';
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
          BlocProvider(create: (context) => sl<NewUserBloc>()),
          BlocProvider(create: (context) => sl<NewGroupBloc>()),
          BlocProvider(create: (context) => sl<SaveGroupBloc>()),
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
