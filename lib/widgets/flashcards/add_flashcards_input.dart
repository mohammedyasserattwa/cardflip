// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class addflashcard_input extends StatelessWidget {
  const addflashcard_input({
    Key? key,
    required this.ControllerData,
    required this.keys,
    this.color,
  }) : super(key: key);

  final TextEditingController ControllerData;
  final GlobalKey keys;
  final bool? color;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ControllerData,
      key: keys,
      decoration: InputDecoration(
        filled: color,
        fillColor: Colors.grey.withOpacity(0.25),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
