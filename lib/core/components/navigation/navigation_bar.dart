import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum TypeUser {
  admin,
  user,
}

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final TypeUser typeUser;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    Key? key,
    required this.typeUser,
    required this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: handledGenerateItem(typeUser),
      currentIndex: selectedIndex,
      unselectedItemColor: CompanyColor
          .color()
          .third,
      selectedItemColor: CompanyColor
          .color()
          .second,
      backgroundColor: CompanyColor
          .color()
          .primary,
      onTap: (int index) => onItemTapped(index),
    );
  }

  List<BottomNavigationBarItem> handledGenerateItem(TypeUser typeUser) {
    switch (typeUser) {
      case TypeUser.admin:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded, size: 27,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded, size: 27,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 27,),
            label: '',
          ),
        ];
      case TypeUser.user:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded, size: 27,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 27,),
            label: '',
          ),
        ];
    }
  }
}
