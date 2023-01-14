import 'package:cardflip/data/Leaderboard.dart';
import 'package:cardflip/data/card.dart';
import 'package:cardflip/data/User.dart';
import 'package:cardflip/data/tag.dart';

class Deck {
  String name;
  String description;
  String author;
  double rating;
  String id;
  List<Card> cards;
  late Leaderboard leaderboard;
  List<Tag> tags = [];
  String userID;
  Map user;
  Deck(
      {required this.name,
      this.description = "",
      this.author = "",
      required this.rating,
      required this.id,
      this.tags = const <Tag>[],
      this.cards = const <Card>[],
      this.userID = "01f4bll7",
      required this.user,
      }) {
    leaderboard = Leaderboard(deckID: id);
  }

  String get deckName => name;
  String get deckDescription => description;
  String get deckAuthor => author;
  String get deckID => id;
  String get deckRating {
    return rating.toStringAsFixed(0);
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
