import 'dart:math';
import 'dart:developer' as developer;
import "package:cardflip/data/Test.dart";
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/screens/testresults.dart';
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
  TestModel({required this.deck}) {
    Map<String, dynamic> testResults = {};

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

  addTestResults(Map wrong, List missed, String time, String userID) async {
    testResults = {
      "deckID": deck.id,
      "duration": time,
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
        .then((value) {
      if (value.docs.isEmpty) {
        _testCollection.add(testResults);
      } else {
        _testCollection.doc(value.docs[0].id).update(testResults);
      }
    });
  }

  get gettestResults => testResults;
  get getdeckCards => deck.cards;
  get getTerms => terms;
  get getTestCards => testCards;
}
