import 'package:cardflip/data/deck.dart';
import 'package:cardflip/data/uncompleted_decks.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

// ignore: non_constant_identifier_names
final FavouritesProvider = StateProvider<List<dynamic>>((ref) {
  // [DATABASE ALGORITHM] here...
  return <String>[];
});
// ignore: non_constant_identifier_names
final RatingProvider = StateProvider<List<String>>((ref) {
  return <String>[];
});
// ignore: non_constant_identifier_names
final ReportProvider = StateProvider<List<String>>((ref) {
  return <String>[];
});
final UnCompletedDecksProvider = StateProvider<Future<String>>((ref) async {
  await UncompletedDecks.init();
  return UncompletedDecks.uncompletedDecks;
});
