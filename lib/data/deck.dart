import 'package:cardflip/data/card.dart';

class Deck {
  String name;
  String description;
  String author;
  double rating;
  String id;
  List<Card> cards;
  String userID;
  Deck(
      {required this.name,
      required this.description,
      required this.author,
      required this.rating,
      required this.id,
      this.cards = const <Card>[],
      this.userID = "01f4bll7"
      });
  String get deckName => name;
  String get deckDescription => description;
  String get deckAuthor => author;
  String get deckID => id;
  String get deckRating {
    return (rating / 1000).toStringAsFixed(1);
  }

  List<Card> get deckCards => cards;

  void incrementRating() {
    rating++;
  }

  void decrementRating() {
    rating--;
  }
}
