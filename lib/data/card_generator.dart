import 'dart:math';

class CardGenerator {
  int color = 0;
  int shape = 0;
  List<String> decks = [
    "Software Engineering",
    "Accounting",
    "International Relations",
    "Music",
    "Astrology",
    "Philosophy",
    "Biology",
    "Climatology",
    "Machine Learning",
    "Mobile Application Development",
    "Literature",
    "Calculus"
  ];
  List<double> ratings = [1, 1.5, 2, 2.3, 2.5, 3, 3.5, 3.8, 4, 4.5, 4.1, 5];
  // List<String> Categories = [];

  int get getcolor {
    return Random().nextInt(16);
  }

  int get getshape {
    return Random().nextInt(3);
  }

  String get deck {
    return decks[Random().nextInt(decks.length)];
  }

  double get rating {
    return ratings[Random().nextInt(ratings.length)];
  }
  int get librarycolor{
    return Random().nextInt(18);
  }
}
