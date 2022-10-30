// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import '../models/LoginModel.dart';

class Input extends StatelessWidget {
  Input({
    Key? key,
    required this.Object,
    required this.validator,
    required this.hintTextOne,
    required this.icon,
    required this.obscureText,
    required this.color,
  }) : super(key: key);

  final loginModel Object;
  final bool obscureText;
  final String? Function(String?) validator;
  final String hintTextOne;
  final IconData icon;
  final Color? color;
  static final registerKey = GlobalKey<FormState>();
  static final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onSaved: (val) {},
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        color: Colors.black,
        height: 1,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
        hintText: hintTextOne,
        hintStyle: TextStyle(
          color: Color(0xFF9395A4),
          decoration: TextDecoration.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
