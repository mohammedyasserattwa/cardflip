import 'dart:math';

class RandomGenerator {
  int color = 0;
  int shape = 0;
  List<int> colorqueue = [];

  int get getcolor {
    while (true) {
      int color = Random().nextInt(16);
      if (colorqueue.contains(color)) {
        continue;
      }
      colorqueue.add(color);
      return color;
    }
  }

  int get getshape {
    return Random().nextInt(3);
  }

  int get librarycolor {
    return Random().nextInt(18);
  }
}
