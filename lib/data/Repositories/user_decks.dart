import 'package:cardflip/data/Notifiers/deck_notifier.dart';
import 'package:cardflip/data/deck.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

final FavouritesProvider = StateProvider<List<String>>((ref) {
  // [DATABASE ALGORITHM] here...
  return <String>[];
});
final RatingProvider = StateProvider<List<String>>((ref) {
  return <String>[];
});
final ReportProvider = StateProvider<List<String>>((ref) {
  return <String>[];
});
