import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';


enum ElevationCount{
  E0,
  E26,
  E12,
  E38,
  E54,
  E45,
  E87,
  E100
}

class CustomAppBarModel {
  final Widget body;
  final double? height;
  final ElevationCount elevation;
  final Function handledGoBack;

  CustomAppBarModel({
    this.height = 110,
    this.elevation = ElevationCount.E0,
    required this.body,
    required this.handledGoBack,
  });
}

class CustomAppBar extends StatelessWidget {
  final CustomAppBarModel model;

  const CustomAppBar({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: _getElevation(model.elevation),
            offset: const Offset(0,2),
            spreadRadius: 2,
            blurRadius: 4,
          )
        ]

      ),
      height: model.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.arrow_back_ios,
              color: CompanyColor.color().primary,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
                child: model.body)
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Color _getElevation(ElevationCount elevation){
    switch (elevation) {
      case ElevationCount.E0:
        return Colors.transparent;
      case ElevationCount.E26:
        return Colors.black26;
      case ElevationCount.E12:
        return Colors.black12;
      case ElevationCount.E38:
        return Colors.black38;
      case ElevationCount.E54:
        return Colors.black54;
      case ElevationCount.E45:
        return Colors.black45;
      case ElevationCount.E87:
        return Colors.black87;
      case ElevationCount.E100:
        return Colors.black;
    }
  }
}
