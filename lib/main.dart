import 'package:almanubis/routes.dart';
import 'package:almanubis/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp();*/
  /*SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);*/
  WidgetsFlutterBinding.ensureInitialized();

  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Almanubis',
          theme: ThemeData(
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white),
          //  onGenerateRoute: Routes.generateRoute,
          home: TestPage(),
        ));
  }
}
