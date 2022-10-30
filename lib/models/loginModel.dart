// ignore_for_file: file_names, camel_case_types

import "package:cardflip/data/User.dart";

class loginModel {
  final User _data;
  loginModel(User data) : _data = data;

  String? get fname {
    return _data.firstname;
  }

  String? get password {
    return _data.getPassword;
  }

  String? get email {
    return _data.getEmail;
  }
}
