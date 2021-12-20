import 'package:almanubis/features/admin_panel/presentation/pages/admin_panel.dart';
import 'package:almanubis/features/list_chat/presentation/pages/list_chat.dart';
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
      case '/newUser': return MaterialPageRoute(builder: (_) => const NewUser());
      case '/listChat': return MaterialPageRoute(builder: (_) => const ListChat());
      case '/adminPanel': return MaterialPageRoute(builder: (_) => const AdminPanel());
      default: return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }}



