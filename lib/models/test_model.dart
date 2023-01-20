import 'dart:developer' as developer;
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/leaderboard_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  final _testCollection = FirebaseFirestore.instance.collection("testresults");

  late Deck deck;
  DeckModel deckModel = DeckModel();
  Map testCards = {};
  late List terms = [];
  late int length;
  late Map<String, dynamic> testResults;
  late LeaderboardModel leaderboardModel = LeaderboardModel(deck: deck);
  TestModel({required this.deck}) {
    length = deck.cards.length;
    terms = deckModel.deckTerms(deck);
    List randomTerms = [...terms];
    String firstRandomTerm = "";
    String secondRandomTerm = "";
    String rightAnswer = "";

    for (int i = 0; i < deck.cards.length; i++) {
      rightAnswer = deck.cards[i].term;
      randomTerms.remove(rightAnswer);
      randomTerms.shuffle();
      firstRandomTerm = randomTerms[0];
      secondRandomTerm = randomTerms[1];
      testCards.addAll({
        deck.cards[i].definition: [
          rightAnswer,
          firstRandomTerm,
          secondRandomTerm
        ]
      });
      randomTerms = [...terms];
    }
  }

  Future addTestResults(
      Map wrong, List missed, String time, var seconds, String userID) async {
    testResults = {
      "deckID": deck.id,
      "duration": time,
      "seconds": seconds,
      "missed": missed,
      "percentage": (100 *
              (testCards.length - (wrong.length + missed.length)) /
              testCards.length)
          .round(),
      "userID": userID,
      "wrong": wrong,
    };

    _testCollection
        .where('userID', isEqualTo: userID)
        .where('deckID', isEqualTo: deck.id)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        _testCollection.add(testResults);
      } else {
        _testCollection.doc(value.docs[0].id).update(testResults);
      }

      await leaderboardModel.updateLeaderboard(
          (100 *
                  (testCards.length - (wrong.length + missed.length)) /
                  testCards.length)
              .round(),
          seconds,
          userID,
          _testCollection,
          deck.id);
    });
  }

  get gettestResults => testResults;
  get getdeckCards => deck.cards;
  get getTerms => terms;
  get getTestCards => testCards;
}
