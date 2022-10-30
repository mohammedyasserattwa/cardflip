import "package:cardflip/data/dummy_data.dart";

class ProfileModel {
  final DummyData _data;
  ProfileModel(DummyData data) : _data = data;

  String get fname {
    return _data.fname;
  }

  String get lname {
    return _data.lname;
  }
}
