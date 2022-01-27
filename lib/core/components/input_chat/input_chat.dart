import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum InputChatColor {
  light,
  dark,
}

enum InputChatType { number, string, password, email }

class InputChatColorModel {
  final String label;
  final bool isObscure;
  final InputChatColor color;
  final InputChatType typeInput;
  final TextEditingController? controller;
  final Function(String) handledChangeInput;

  InputChatColorModel({
    this.label = "",
    this.controller,
    this.isObscure = false,
    required this.handledChangeInput,
    this.color = InputChatColor.light,
    this.typeInput = InputChatType.string,
  });
}

class InputChat extends StatelessWidget {
  final InputChatColorModel model;
  final borderSide = const BorderSide(color: Colors.transparent);

  const InputChat({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: model.controller,
      obscureText: model.isObscure,
      style: TextStyle(
        fontSize: 17.0,
        color: CompanyColor.color().third,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: _getColor(model.color),
      keyboardType: _getTypeInput(model.typeInput),
      onChanged: (String text){
        model.handledChangeInput(text);
      },
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
          color: CompanyColor.color().third,
          fontWeight: FontWeight.w500,
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

  Color _getColor(InputChatColor color) {
    switch (color) {
      case InputChatColor.light:
        return CompanyColor.color().second;
      case InputChatColor.dark:
        return CompanyColor.color().primary;
    }
  }

  TextInputType _getTypeInput(InputChatType type) {
    switch (type) {
      case InputChatType.number:
        return TextInputType.phone;
      case InputChatType.email:
        return TextInputType.emailAddress;
      case InputChatType.string:
        return TextInputType.text;
      case InputChatType.password:
        return TextInputType.visiblePassword;
    }
  }
}
