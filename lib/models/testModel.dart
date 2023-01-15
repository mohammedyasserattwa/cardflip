import 'dart:math';
import 'dart:developer' as developer;
import "package:cardflip/data/Test.dart";
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';

class TestModel {
  late Deck deck;
  late Test test;
  DeckModel deckModel = DeckModel();
  late var testCards = {};
  late List terms = [];
  late int length;

  TestModel({required this.deck}) {
    late final random = Random();
    length = deck.cards.length;

    terms = deckModel.deckTerms(deck);
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
    // test = Test(deck: deck);
  }

  get getTerms => terms;
  get getTestCards => testCards;
}
