import 'package:almanubis/core/util/company_colors.dart';
import 'package:flutter/material.dart';

enum InputEditAccountType {
  title,
  description,
}

class InputEditAccountModel {
  final TextEditingController? controller;
  final InputEditAccountType typeInput;
  final String label;
  final bool isObscure;
  final Function(dynamic)? validator;
  final Function? tapIcon;

  InputEditAccountModel({
    this.typeInput = InputEditAccountType.title,
    this.isObscure = false,
    this.label = "",
    this.controller,
    this.tapIcon,
    this.validator,
  });
}

class InputEditAccount extends StatefulWidget {
  final InputEditAccountModel model;

  const InputEditAccount({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<InputEditAccount> createState() => _InputEditAccountState();
}

class _InputEditAccountState extends State<InputEditAccount> {
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isFocused = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide =
        const BorderSide(width: 0, color: Colors.transparent);

    return TextFormField(
      focusNode: focusNode,
      autofocus: false,
      controller: widget.model.controller,
      obscureText: widget.model.isObscure,
      style: _getStyleTextInput(widget.model.typeInput),
      textAlign: TextAlign.center,
      cursorColor: CompanyColor.color().primary,
      keyboardType: TextInputType.text,
      validator: (e) =>
          widget.model.validator != null ? widget.model.validator!(e) : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 1),
        hintText: (isFocused) ? '' : widget.model.label,
        hintStyle: _getStyleTextInput(widget.model.typeInput),
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
