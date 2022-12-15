// ignore_for_file: file_names, camel_case_types

import 'package:cardflip/data/User.dart';

class loginModel {
  final User data;

  loginModel({required this.data});

  String get fname {
    return data.fname;
  }

  String get password {
    return data.getPassword;
  }

  String get email {
    return data.getEmail;
  }
}
