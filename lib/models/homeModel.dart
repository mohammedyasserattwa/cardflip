// ignore_for_file: file_names

import "package:cardflip/data/dummy_data.dart";

class HomeModel {
  final DummyData _data;
  HomeModel(DummyData data) : _data = data;

  String get fname {
    return _data.fname;
  }

  String get lname {
    return _data.lname;
  }

  int get flashcardnumber {
    return _data.flashcard;
  }

  double get rating {
    return _data.ratingnumber;
  }
}
