import 'package:cardflip/data/deck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      required this.background});
  String get categoryName => name;
  List<Deck> get categoryDecks => decks;
  String get categoryImage => vector;
  factory Category.fromSnapshot(dynamic params) {
    return Category(
      id: params["id"],
      name: params["name"],
      decks: params["decks"],
      vector: params["vector"],
      background: params["background"]
    );
  }
}
