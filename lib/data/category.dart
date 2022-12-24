import 'package:cardflip/data/deck.dart';

class Category {
  String name;
  List<Deck> decks = <Deck>[];
  String vector;
  String background;
  String id;
  Category(
      {required this.id,
      required this.name,
      required this.decks,
      required this.vector,
      required this.background
      });
  String get categoryName => name;
  List<Deck> get categoryDecks => decks;
  String get categoryImage => vector;
}
