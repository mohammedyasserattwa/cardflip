import 'package:cardflip/data/card.dart';

class Deck {
  String name;
  String description;
  String author;
  double rating;
  String id;
  List<Card> cards;
  Deck(
      {required this.name,
      required this.description,
      required this.author,
      required this.rating,
      required this.id,
      this.cards = const <Card>[]});
  String get deckName => name;
  String get deckDescription => description;
  String get deckAuthor => author;
  String get deckID => id;
  double get deckRating => rating;
  List<Card> get deckCards => cards;

  void incrementRating() {
    rating++;
  }
}
