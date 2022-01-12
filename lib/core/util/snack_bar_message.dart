import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

snackBarMessage(BuildContext context, {required String message}){
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}