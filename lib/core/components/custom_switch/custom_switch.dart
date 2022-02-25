import 'package:almanubis/core/util/company_colors.dart';
import 'package:almanubis/core/util/company_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {

  final bool state;
  final String label;
  final Function(bool) handledSwitch;

  const CustomSwitch({Key? key,
    required this.label,
    required this.state,
    required this.handledSwitch,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          label,
          style: CompanyFontStyle.style().textDescription
        ),
        Switch(
          value: state,
          activeColor: CompanyColor.color().second,
          onChanged: handledSwitch,
        ),
      ],
    );
  }
}
