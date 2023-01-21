import 'package:cardflip/data/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Deck {
  String name;
  String description;
  String author;
  int rating = 0;
  List<String> likes = [];
  String id;
  List<Card> cards;
  List<String> tags = [];
  String userID;
  Map user;
  Deck({
    required this.name,
    this.description = "",
    this.author = "",
    required this.id,
    this.tags = const <String>[],
    this.cards = const <Card>[],
    this.likes = const <String>[],
    required this.userID,
    required this.user,
  }) {
    rating = likes.length;
    // leaderboard = Leaderboard(deckID: id);
  }
  factory Deck.fromMap(Map<String, dynamic> map, Map user, String id) {
    List<Card> cards = [];
    final flashcards = map["flashcards"];
    for (int i = 0; i < flashcards.length; i++) {
      cards.add(Card.fromMap(flashcards[i]));
    }
    List<String> likes =
        (map["likes"] as List).map((e) => e as String).toList();
    return Deck(
        name: map['name'],
        description: map['description'],
        id: id,
        userID: map['userID'],
        tags: (map["tags"] as List).map((item) => item as String).toList(),
        cards: cards,
        user: user,
        likes: likes);
  }
  factory Deck.fromSnapshot(QueryDocumentSnapshot<Map> map, Map user) {
    List<Card> cards = [];
    final flashcards = map["flashcards"];
    for (int i = 0; i < flashcards.length; i++) {
      cards.add(Card.fromMap(flashcards[i]));
    }
    List<String> likes =
        (map["likes"] as List).map((e) => e as String).toList();
    return Deck(
        name: map['name'],
        description: map['description'],
        id: map.id,
        userID: map['userID'],
        tags: (map["tags"] as List).map((item) => item as String).toList(),
        cards: cards,
        user: user,
        likes: likes);
  }

  setFlashcards(List<Map<String, String>> flashcards) {
    List<Card> cards = [];
    for (int i = 0; i < flashcards.length; i++) {
      cards.add(Card.fromMap(flashcards[i]));
    }
    this.cards = cards;
  }

  String get deckName => name;
  String get deckDescription => description;
  String get deckAuthor => author;
  String get deckID => id;
  String get deckRating {
    return rating.toStringAsFixed(0);
  }

  List<Card> get deckCards => cards;

  void incrementRating() {
    rating++;
  }

  void decrementRating() {
    rating--;
  }
}
