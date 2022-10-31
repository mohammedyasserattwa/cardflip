import "package:cardflip/data/testdata.dart";

class testModel {
  final test _data;
  testModel(test data) : _data = data;

  String get q {
    return _data.q;
  }

  String get c1 {
    return _data.c1;
  }

  String get c2 {
    return _data.c2;
  }

  String get c3 {
    return _data.c3;
  }
}
