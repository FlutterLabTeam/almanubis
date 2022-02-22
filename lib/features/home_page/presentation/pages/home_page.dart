import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/components/navigation/navigation_bar.dart';
import 'package:almanubis/features/home_page/presentation/bloc/home_bloc.dart';
import 'package:almanubis/features/list_chat/presentation/pages/list_chat.dart';
import 'package:almanubis/features/admin_panel/presentation/pages/admin_panel.dart';
import 'package:almanubis/features/user_configuration/presentation/pages/user_configuration.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;

  const HomePage({Key? key, required this.userModel}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.userModel.rol == "ADMIN" ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ChangeViewState) {
          _selectedIndex = state.page;
        }
        return Scaffold(
          body: handledGenerateView(widget.userModel.rol)
              .elementAt(_selectedIndex),
          bottomNavigationBar: CustomNavigationBar(
            typeUser: widget.userModel.rol == "ADMIN"
                ? TypeUser.admin
                : TypeUser.user,
            selectedIndex: _selectedIndex,
            onItemTapped: (int index) => BlocProvider.of<HomeBloc>(context)
                .add(ChangeViewEvent(page: index)),
          ),
        );
      },
    );
  }

  List<Widget> handledGenerateView(String rol) {
    switch (rol) {
      case "ADMIN":
        return <Widget>[
          ListChat(userModel: widget.userModel),
          AdminPanel(userModel: widget.userModel),
          UserConfiguration(userModel: widget.userModel),
        ];
      case "USER":
        return <Widget>[
          ListChat(userModel: widget.userModel),
          UserConfiguration(userModel: widget.userModel),
        ];
      default:
        return <Widget>[
          ListChat(userModel: widget.userModel),
          AdminPanel(userModel: widget.userModel),
          UserConfiguration(userModel: widget.userModel),
        ];
    }
  }
}
