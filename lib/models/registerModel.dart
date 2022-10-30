// ignore_for_file: file_names

import "package:cardflip/data/User.dart";

class RegisterModel {
  final User _data;
  RegisterModel(User data) : _data = data;

  String? get fname {
    return _data.first_name;
  }

  String? get password {
    return _data.password;
  }

  String? get email {
    return _data.email;
  }
}
