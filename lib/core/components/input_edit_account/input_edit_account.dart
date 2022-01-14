import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum InputEditAccountType {
  title,
  description,
}

class InputEditAccountColorModel {
  final TextEditingController? controller;
  final InputEditAccountType typeInput;
  final String label;
  final bool isObscure;
  final Function(dynamic)? validator;
  final Function? tapIcon;

  InputEditAccountColorModel({
    this.typeInput = InputEditAccountType.title,
    this.isObscure = false,
    this.label = "",
    this.controller,
    this.tapIcon,
    this.validator,
  });
}

class InputEditAccount extends StatelessWidget {
  final InputEditAccountColorModel model;

  const InputEditAccount({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide = const BorderSide(width: 0, color: Colors.transparent);
    return TextFormField(
      autofocus: false,
      controller: model.controller,
      obscureText: model.isObscure,
      style: _getStyleTextInput(model.typeInput),
      textAlign: TextAlign.center,
      cursorColor: CompanyColor.color().primary,
      keyboardType: TextInputType.text,
      validator: (e) => model.validator != null ? model.validator!(e) : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 1),
        hintText: model.label,
        hintStyle: _getStyleTextInput(model.typeInput),
        border: OutlineInputBorder(
          borderSide: borderSide,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),
    /*    errorBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),*/
        disabledBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),
      ),
    );
  }


  TextStyle _getStyleTextInput(InputEditAccountType type) {
    switch (type) {
      case InputEditAccountType.title:
        return TextStyle(
          color: CompanyColor.color().primary,
          fontWeight: FontWeight.w500,
          fontSize: 25,
        );
      case InputEditAccountType.description:
        return TextStyle(
          color: CompanyColor.color().primary,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
    }
  }
}
