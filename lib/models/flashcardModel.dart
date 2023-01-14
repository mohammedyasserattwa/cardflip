import 'dart:collection';

import 'package:cardflip/data/card.dart';

import '../data/deck.dart';
import 'deckModel.dart';

class FlashcardModel {
  // String id;
  Deck deck;
  FlashcardModel({required this.deck}) {
    queue = deck.cards.length;
  }
  final bool personalDeck = false;
  final List<String> _cardBackgrounds = [
    "Images/cards/flashcards/2.png",
    "Images/cards/flashcards/1.png",
    "Images/cards/flashcards/0.png",
  ];
  int queue = 0;
  List<Card> get favourites =>
      deck.cards.where((card) => card.isFavourite).toList();

  String get rating => "${deck.deckRating}k";
  List<Card> get getCards => deck.cards;
  List<String> get getImages => _cardBackgrounds;

  void pushForward(String id) {
    Card temp = deck.cards.firstWhere((element) => element.id == id);
    deck.cards.remove(temp);
    deck.cards.add(temp);
  }

  void filter() {
    /// Sorting the cards by term.
    deck.cards.sort(((a, b) =>
        a.term.toLowerCase().trim().compareTo(b.term.toLowerCase().trim())));
  }

  void addRating() {
    deck.incrementRating();
  }
}
