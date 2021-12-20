import 'package:almanubis/features/admin_panel/presentation/pages/admin_panel.dart';
import 'package:almanubis/features/new_user/presentation/pages/new_user.dart';
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
      case '/adminPanel': return MaterialPageRoute(builder: (_) => const AdminPanel());
      case '/newUser': return MaterialPageRoute(builder: (_) => const NewUser());
      default: return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }}



