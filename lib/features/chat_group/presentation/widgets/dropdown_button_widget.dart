import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  final List<IconData> listElement;
  final Function(dynamic) handledTapInOption;

  const DropdownButtonWidget({Key? key, required this.listElement, required this.handledTapInOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      iconSize: 0,
      alignment: Alignment.center,
      dropdownColor: CompanyColor.color().primary,
      underline: Container(),
      items: listElement
          .map((IconData e) => DropdownMenuItem(
                child: Icon(
                  e,
                  size: 25,
                  color: Colors.white,
                ),
                value: e,
              ))
          .toList(),
      onChanged: (e) => handledTapInOption(e),
      hint: const Icon(
        Icons.link,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
