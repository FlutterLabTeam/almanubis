import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum CustomInputColor {
  light,
  dark,
}

enum CustomInputType { number, string, password, email }

class CustomInputColorModel {
  final TextEditingController? controller;
  final CustomInputType typeInput;
  final CustomInputColor color;
  final String label;
  final bool isObscure;

  CustomInputColorModel({
    this.typeInput = CustomInputType.string,
    this.color = CustomInputColor.light,
    this.controller,
    this.isObscure = false,
    this.label = "",
  });
}

class CustomInput extends StatelessWidget {
  final CustomInputColorModel model;

  const CustomInput({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: _getColor(model.color), width: 2);
    return TextFormField(
      autofocus: false,
      obscureText: model.isObscure,
      style: TextStyle(
        fontSize: 17.0,
        color: _getColor(model.color),
        fontWeight: FontWeight.w300,
      ),
      cursorColor: _getColor(model.color),
      keyboardType: _getTypeInput(model.typeInput),
      decoration: InputDecoration(
        suffixIcon:
            _getTypeInput(model.typeInput) == TextInputType.visiblePassword
                ? model.isObscure
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: _getColor(model.color),
                        ),
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.visibility_off,
                          color: _getColor(model.color),
                        ),
                      )
                : null,
        hintText: model.label,
        hintStyle: TextStyle(
          color: _getColor(model.color),
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderSide: borderSide,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: borderSide,
        ),
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

  Color _getColor(CustomInputColor color) {
    switch (color) {
      case CustomInputColor.light:
        return CompanyColor.color().second;
      case CustomInputColor.dark:
        return CompanyColor.color().primary;
    }
  }

  TextInputType _getTypeInput(CustomInputType type) {
    switch (type) {
      case CustomInputType.number:
        return TextInputType.phone;
      case CustomInputType.email:
        return TextInputType.emailAddress;
      case CustomInputType.string:
        return TextInputType.text;
      case CustomInputType.password:
        return TextInputType.visiblePassword;
    }
  }
}
