import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/features/information_panel_groups/presentation/pages/information_panel_groups.dart';
import 'package:almanubis/features/new_group/presentation/pages/new_group.dart';
import 'package:almanubis/features/save_group/presentation/pages/save_group.dart';
import 'package:almanubis/features/user_configuration/presentation/pages/user_configuration.dart';
import 'package:almanubis/features/admin_panel/presentation/pages/admin_panel.dart';
import 'package:almanubis/features/chat_group/presentation/pages/chat_group.dart';
import 'package:almanubis/features/list_chat/presentation/pages/list_chat.dart';
import 'package:almanubis/features/new_user/presentation/pages/new_user.dart';
import 'package:almanubis/features/auth/presentation/pages/auth.dart';
import 'package:almanubis/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    List<UserModel> listUserModel = [];
    UserModel userModel= UserModel.fromJsonNoData();
    final argument  = settings.arguments;

    if(argument is List<UserModel>){
      listUserModel = argument;
    }
    if(argument is UserModel){
      userModel = argument;
    }

    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => const AppSplashScreen());
      case '/newUser': return MaterialPageRoute(builder: (_) => const NewUser());
      case '/authPage': return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/newGroup': return MaterialPageRoute(builder: (_) => const NewGroup());
      case '/listChat': return MaterialPageRoute(builder: (_) =>  ListChat(userModel: userModel));
      case '/chatGroup': return MaterialPageRoute(builder: (_) => const ChatGroup());
      case '/adminPanel': return MaterialPageRoute(builder: (_) => AdminPanel(userModel: userModel,));
      case '/saveGroup': return MaterialPageRoute(builder: (_) =>  SaveGroup(listUser: listUserModel));
      case '/userConfiguration': return MaterialPageRoute(builder: (_) => UserConfiguration(userModel: userModel));
      case '/informationPanelGroups': return MaterialPageRoute(builder: (_) => const InformationPanelGroups(typeUser: InformationPanelGroupsEnum.admin));
      default: return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }}



