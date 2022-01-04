import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum InputSearchType { number, string, password, email }

class InputSearchColorModel {
  final TextEditingController? controller;
  final InputSearchType typeInput;
  final String label;
  final bool isObscure;

  InputSearchColorModel({
    this.typeInput = InputSearchType.string,
    this.controller,
    this.isObscure = false,
    this.label = "",
  });
}

class InputSearch extends StatelessWidget {
  final InputSearchColorModel model;

  const InputSearch({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: model.isObscure,
      style: TextStyle(
        fontSize: 17.0,
        color: CompanyColor.color().third,
        fontWeight: FontWeight.w300,
      ),
      cursorColor: CompanyColor.color().third,
      keyboardType: _getTypeInput(model.typeInput),
      decoration: InputDecoration(
        filled: true,
        fillColor: CompanyColor.color().primary,
        hintText: model.label,
        hintStyle: TextStyle(
          color: CompanyColor.color().third,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        border: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  TextInputType _getTypeInput(InputSearchType type) {
    switch (type) {
      case InputSearchType.number:
        return TextInputType.phone;
      case InputSearchType.email:
        return TextInputType.emailAddress;
      case InputSearchType.string:
        return TextInputType.text;
      case InputSearchType.password:
        return TextInputType.visiblePassword;
    }
  }
}
