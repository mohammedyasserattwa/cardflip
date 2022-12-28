import 'package:cardflip/data/Leaderboard.dart';
import 'package:cardflip/data/card.dart';
import 'package:cardflip/data/User.dart';

class Deck {
  String name;
  String description;
  String author;
  double rating;
  String id;
  List<Card> cards;
  late Leaderboard leaderboard;
  String userID;
  Deck(
      {required this.name,
      required this.description,
      required this.author,
      required this.rating,
      required this.id,
      this.cards = const <Card>[],
      this.userID = "01f4bll7"}) {
    leaderboard = Leaderboard(deckID: id);
  }

  String get deckName => name;
  String get deckDescription => description;
  String get deckAuthor => author;
  String get deckID => id;
  String get deckRating {
    return (rating / 1000).toStringAsFixed(1);
  }

  List<Card> get deckCards => cards;

  Leaderboard get deckLeaderboard => leaderboard;

  void incrementRating() {
    rating++;
  }

  void decrementRating() {
    rating--;
  }
}
