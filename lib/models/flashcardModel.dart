import 'dart:collection';

import 'package:cardflip/data/card.dart';

import '../data/deck.dart';

class FlashcardModel {
  final Deck deck = Deck(
      name: "Meteorology",
      description:
          "Some vocabulary terms and definitions related to meteorology",
      author: "Lara",
      id: "1",
      rating: 4099,
      cards: [
        Card(id: 0, term: "Math", definition: "Math Definition"),
        Card(id: 1, term: "Physics", definition: "Physics Definition"),
        Card(id: 2, term: "Biology", definition: "Biology Definition"),
        Card(id: 3, term: "Chemistry", definition: "Chemistry Definition"),
        Card(
            id: 4,
            term: "Computer Science",
            definition: "Computer Science Definition"),
        Card(
            id: 5,
            term: "Machine Learning",
            definition: "Machine Learning Definition"),
      ]);
  final bool personalDeck = false;
  final List<String> _terms = [
    "Math",
    "Physics",
    "Biology",
    "Chemistry",
    "Computer Science",
    "Machine Learning",
    "Machine Learning2",
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
    Card(id: 0, term: "Math", definition: "Math Definition"),
    Card(id: 1, term: "Physics", definition: "Physics Definition"),
    Card(id: 2, term: "Biology", definition: "Biology Definition"),
    Card(id: 3, term: "Chemistry", definition: "Chemistry Definition"),
    Card(
        id: 4,
        term: "Computer Science",
        definition: "Computer Science Definition"),
    Card(
        id: 5,
        term: "Machine Learning",
        definition: "Machine Learning Definition"),
    Card(
        id: 6,
        term: "Machine Learning2",
        definition: "Machine Learning Definition"),
  ];
  int queue = 0;
  FlashcardModel() {
    queue = cards.length;
  }
  List<Card> get favourites => cards.where((card) => card.isFavourite).toList();

  String get rating => "${(deck.deckRating / 1000).floor()}k";
  List<String> get getTerms => _terms;
  List<String> get getDefinitions => _definitions;
  List<Card> get getCards => cards;
  List<String> get getImages => _cardBackgrounds;

  void pushForward(int id) {
    Card temp = cards.firstWhere((element) => element.id == id);
    cards.remove(temp);
    cards.add(temp);
  }

  void filter() {
    /// Sorting the cards by term.
    cards.sort(((a, b) =>
        a.term.toLowerCase().trim().compareTo(b.term.toLowerCase().trim())));
  }

  void addRating() {
    deck.incrementRating();
  }
}
