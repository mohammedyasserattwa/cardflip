import 'package:cardflip/classes.dart';
import 'package:flutter/material.dart';

class DeckNotifier extends ChangeNotifier {
  final favourites = <String>[];
  void addDeck(String id) {
    favourites.add(id);
    notifyListeners();
  }
  void removeDeck(String id) {
    favourites.remove(favourites.firstWhere((element) => element == id));
    notifyListeners();
  }
}
