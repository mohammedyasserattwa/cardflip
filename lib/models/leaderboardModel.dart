import 'dart:collection';

import 'package:cardflip/data/Leaderboard.dart';
import 'package:cardflip/data/User.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/userModel.dart';
import "dart:developer" as developer;

class LeaderboardModel {
  String id;
  late Leaderboard leaderboard;
  late Deck deck;
  UserModel userModel = UserModel();
  DeckModel deckModel = DeckModel();
  // function to add in list of lists in leaderboard.dart
  // todo clear list each time opened
  LeaderboardModel({required this.id}) {
    // deck = deckModel.deckByID(id);
    leaderboard = Leaderboard(deckID: id);
  }

  // List<User> get leaderboardList {
  //   return deck.leaderboard.leaderboardList;
  // }

  Future leaderboardData(String id) async {
    var usersInfo = [];
    var ranks = [];
    var map = {};
    
    var data = await deckModel.leaderboardUsers(id);

    for (int i = 0; i < data.length; i++) {
      usersInfo.add(await userModel.userNameandPic(data[i]!['userID']));
      ranks.add((data[i]!['rank']));
    }

    for (int i = 0; i < data.length; i++) {
      map[ranks[i]] = {
        'rank': ranks[i],
        'userInfo': usersInfo[i],
      };
    }

    developer.log("map ${map.runtimeType} map length ${map.length} $map");

    var s = SplayTreeMap.from(map, (a, b) {
      if (map[a] != null && map[b] != null)
        return int.parse(map[a]['rank']).compareTo(int.parse(map[b]['rank']));
      return 0;
    });
    developer.log("s $s");
    return s;
  }
}
