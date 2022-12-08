import 'dart:collection';

import 'package:cardflip/data/card.dart';

class FlashcardModel {
  final List<String> _terms = [
    "Math",
    "Physics",
    "Biology",
    "Chemistry",
    "Computer Science",
    "Machine Learning"
  ];
  final List<String> _definitions = [
    "Math Definition",
    "Physics definition",
    "Biology Definition",
    "Chemistry Definition",
    "Computer Science",
    "Machine Learning"
  ];
  final List<String> _cardBackgrounds = [
    "Images/cards/flashcards/2.png",
    "Images/cards/flashcards/1.png",
    "Images/cards/flashcards/0.png",
  ];
  final List<Card> cards = [
    Card(term: "Math", definition: "Math Definition"),
    Card(term: "Physics", definition: "Physics Definition"),
    Card(term: "Biology", definition: "Biology Definition"),
    Card(term: "Chemistry", definition: "Chemistry Definition"),
    Card(term: "Computer Science", definition: "Computer Science Definition"),
    Card(term: "Machine Learning", definition: "Machine Learning Definition"),
  ];
  int queue = 0;
  FlashcardModel() {
    queue = cards.length;
  }
  List<Card> get favourites => cards.where((card) => card.isFavourite).toList();

  List<String> get getTerms => _terms;
  List<String> get getDefinitions => _definitions;
  List<Card> get getCards => cards;
  List<String> get getImages => _cardBackgrounds;
}
