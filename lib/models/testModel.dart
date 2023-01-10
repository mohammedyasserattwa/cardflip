import 'dart:math';

import "package:cardflip/data/Test.dart";
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';

class TestModel {
  String id;
  late Deck deck;
  late Test test;
  DeckModel deckModel = DeckModel();
  late var testCards = {};
  late List terms = [];

  TestModel({required this.id}) {
    deck = deckModel.deckByID(id);
    late final random = Random();
    late final int length = deckModel.deckByID(id).cards.length;
    terms = deckModel.deckTerms(id);
    var firstRandomTerm = terms[random.nextInt(length - 1)];
    var secondRandomTerm = terms[random.nextInt(length - 1)];

    for (int i = 0; i < deck.cards.length; i++) {
      firstRandomTerm = terms[random.nextInt(length - 1)];
      secondRandomTerm = terms[random.nextInt(length - 1)];
      while (true) {
        if (firstRandomTerm == secondRandomTerm ||
            deck.cards[i].term == firstRandomTerm ||
            deck.cards[i].term == secondRandomTerm) {
          firstRandomTerm = terms[random.nextInt(length - 1)];
          secondRandomTerm = terms[random.nextInt(length - 1)];
        } else {
          break;
        }
      }
      testCards.addAll({
        deck.cards[i].definition:
            {deck.cards[i].term, firstRandomTerm, secondRandomTerm}.toList()
      });
    }
    test = Test(deckID: id);
  }

  get getTerms => terms;
  get getTestCards => testCards;
}
