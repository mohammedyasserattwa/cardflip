import "package:cardflip/data/Test.dart";
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';

class TestModel {
  String id;
  late Deck deck;
  late Test test;
  DeckModel deckModel = DeckModel();
  // function to add in list of lists in leaderboard.dart
  // clear list each time opened
  TestModel({required this.id}) {
    deck = deckModel.deckByID(id);
    test = Test(deckID: id);
  }
}
