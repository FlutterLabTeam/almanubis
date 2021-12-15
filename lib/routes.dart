import 'package:almanubis/features/auth/presentation/pages/auth.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    /*UserModel userModel = UserModel();*/
    /*final argument  = settings.arguments;*/

    /*if(argument is UserModel){
      userModel = argument;
    }*/

    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => const AuthPage());
      default: return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }}



