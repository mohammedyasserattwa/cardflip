import 'package:cardflip/data/Leaderboard.dart';
import 'package:cardflip/data/User.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';

class LeaderboardModel {
  String id;
  late Leaderboard leaderboard;
  late Deck deck;
  DeckModel deckModel = DeckModel();
  // function to add in list of lists in leaderboard.dart
  // clear list each time opened
  LeaderboardModel({required this.id}) {
    deck = deckModel.deckByID(id);
    leaderboard = Leaderboard(deckID: id);
  }

  List<User> get leaderboardList {
    return deck.leaderboard.leaderboardList;
  }
}
