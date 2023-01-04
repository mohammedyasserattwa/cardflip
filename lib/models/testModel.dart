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

  TestModel({required this.id}) {
    deck = deckModel.deckByID(id);
    late final random = Random();
    late final int length = deckModel.deckByID(id).cards.length;
    late List terms = deckModel.deckTerms(id);
    var firstRandomTerm = terms[random.nextInt(length - 1)];
    terms.remove(firstRandomTerm);
    var secondRandomTerm = terms[random.nextInt(length - 1)];
    terms.remove(secondRandomTerm);
    testCards = Map.fromIterable(deck.cards,
        key: (v) => v.definition,
        value: (v) => [v.term, firstRandomTerm, secondRandomTerm]);

    //     for (var i in deck.cards)  testCards[{deck.cards[i].term}] = {deck.cards[i].definition};

    test = Test(deckID: id);
  }
  get getTestCards => testCards;
}
