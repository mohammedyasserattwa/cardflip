import 'dart:math';
import 'dart:developer' as developer;
import 'package:cardflip/data/test.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/leaderboard_model.dart';
import 'package:cardflip/screens/test/test_results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _testCollection = FirebaseFirestore.instance.collection("testresults");

  late Deck deck;
  late Test test;
  DeckModel deckModel = DeckModel();
  late var testCards = {};
  late List terms = [];
  late int length;
  late bool viable;
  late Map<String, dynamic> testResults;
  late LeaderboardModel leaderboardModel = LeaderboardModel(deck: deck);
  TestModel({required this.deck}) {
    late final random = Random();
    length = deck.cards.length;
    if (length >= 3) {
      viable = true;
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
    } else {
      viable = false;
    }
    // test = Test(deck: deck);
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
