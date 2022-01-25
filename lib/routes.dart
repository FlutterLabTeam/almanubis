import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/features/information_panel_groups/presentation/pages/information_panel_groups.dart';
import 'package:almanubis/features/user_configuration/presentation/pages/user_configuration.dart';
import 'package:almanubis/features/add_new_group/presentation/pages/add_new_user.dart';
import 'package:almanubis/features/admin_panel/presentation/pages/admin_panel.dart';
import 'package:almanubis/features/save_group/presentation/pages/save_group.dart';
import 'package:almanubis/features/chat_group/presentation/pages/chat_group.dart';
import 'package:almanubis/features/list_chat/presentation/pages/list_chat.dart';
import 'package:almanubis/features/new_group/presentation/pages/new_group.dart';
import 'package:almanubis/features/new_user/presentation/pages/new_user.dart';
import 'package:almanubis/features/auth/presentation/pages/auth.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    List<UserModel> listUserModel = [];
    UserModel userModel= UserModel.fromJsonNoData();
    ChatGroupModel chatGroupModel = ChatGroupModel();
    GroupModel groupModel = GroupModel.fromNoDataJson();
    InformationPanelGroupsModel informationPanelGroupsModel = InformationPanelGroupsModel();
    final argument  = settings.arguments;

    if(argument is List<UserModel>){
      listUserModel = argument;
    }
    if(argument is InformationPanelGroupsModel){
      informationPanelGroupsModel = argument;
    }
    if(argument is GroupModel){
      groupModel = argument;
    }
    if(argument is UserModel){
      userModel = argument;
    }
    if(argument is ChatGroupModel){
      chatGroupModel = argument;
    }
    if(argument is InformationPanelGroupsModel){
      informationPanelGroupsModel = argument;
    }

    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => const AppSplashScreen());
      case '/newUser': return MaterialPageRoute(builder: (_) => const NewUser());
      case '/authPage': return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/newGroup': return MaterialPageRoute(builder: (_) => const NewGroup());
      case '/addNewUser': return MaterialPageRoute(builder: (_) => AddNewUser(model: groupModel));
      case '/listChat': return MaterialPageRoute(builder: (_) =>  ListChat(userModel: userModel));
      case '/chatGroup': return MaterialPageRoute(builder: (_) => ChatGroup(model: chatGroupModel,));
      case '/adminPanel': return MaterialPageRoute(builder: (_) => AdminPanel(userModel: userModel,));
      case '/saveGroup': return MaterialPageRoute(builder: (_) =>  SaveGroup(listUser: listUserModel));
      case '/userConfiguration': return MaterialPageRoute(builder: (_) => UserConfiguration(userModel: userModel));
      case '/informationPanelGroups': return MaterialPageRoute(builder: (_) => InformationPanelGroups(model: informationPanelGroupsModel,));
      default: return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }}



