import 'dart:collection';

import 'package:cardflip/data/Leaderboard.dart';
import 'package:cardflip/data/User.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/userModel.dart';
import "dart:developer" as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardModel {
  // String id;
  // late Leaderboard leaderboard;
  late Deck deck;
  UserModel userModel = UserModel();
  DeckModel deckModel = DeckModel();
  // function to add in list of lists in leaderboard.dart
  // todo clear list each time opened
  LeaderboardModel(
      {
      // required this.id,
      required this.deck}) {
    // leaderboard = Leaderboard(deckID: id);
  }

  Future leaderboardData() async {
    var usersInfo = [];
    var ranks = [];
    var map = {};

    var data = await deckModel.leaderboardUsers(deck.id);

    for (int i = 0; i < data.length; i++) {
      usersInfo
          .add(await userModel.getNameandPic(data[i.toString()]!['userID']));

      ranks.add((data[i.toString()]!['rank']));
    }

    for (int i = 0; i < data.length; i++) {
      map[ranks[i]] = {
        'rank': ranks[i],
        'userInfo': usersInfo[i],
      };
    }

    var s = SplayTreeMap.from(map, (a, b) {
      if (map[a] != null && map[b] != null)
        return map[a]['rank'].compareTo(map[b]['rank']);
      return 0;
    });

    return s;
  }

  updateLeaderboard(int percentage, String time, String userID,
      dynamic testCollection, String deckID) async {
    int rank = 0;
    var myoldrank;

    QuerySnapshot snapshot =
        await testCollection.where('deckID', isEqualTo: deckID).get();

    if (snapshot.docs.isNotEmpty) {
      Query rankcalc = testCollection
          .where('percentage', isEqualTo: percentage)
          .where('duration', isEqualTo: time);
      QuerySnapshot snapshot2 = await rankcalc.get();
      int count = snapshot2.docs.length;
      if (snapshot2.docs.isEmpty) {
        Query rankcalc = testCollection
            .where('percentage', isEqualTo: percentage)
            .where('duration', isGreaterThan: time);
        QuerySnapshot snapshot3 = await rankcalc.get();
        int count = snapshot3.docs.length;
        if (snapshot3.docs.isEmpty) {
          Query rankcalc =
              testCollection.where('percentage', isGreaterThan: percentage);
          QuerySnapshot snapshot4 = await rankcalc.get();
          int count = snapshot4.docs.length;
          rank = (count + 1);
        } else
          rank = count;
      } else
        rank = count;
    }

    // developer.log(rank.toString());

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("deck").doc(deckID).get();

    if (doc.exists) {
      var leaderboard = (doc.data() as Map<String, dynamic>)["leaderboard"];

      bool userFound = false;

      for (int i = 0; i < leaderboard.length; i++) {
        try {
          if (leaderboard[i] != null &&
              leaderboard[i].containsKey("userID") &&
              leaderboard[i]["userID"].isNotEmpty &&
              leaderboard[i]["userID"] == userID) {
            userFound = true;
            myoldrank = leaderboard[i]["rank"];
            if (rank > 50 && myoldrank <= 50) {
              //update myrank and subtract 1 from everyone whose rank < myoldrank

              for (int j = 0; j < leaderboard.length; j++) {
                if (leaderboard[j]["rank"] < myoldrank) {
                  FirebaseFirestore.instance
                      .collection("deck")
                      .doc(deckID)
                      .update({
                    "leaderboard.$j": {
                      "leaderboard.$j.rank": leaderboard[j]["rank"] - 1,
                      "leaderboard.$j.userID": userID
                    }
                  });
                }
              }
              FirebaseFirestore.instance.collection("deck").doc(deckID).update({
                "leaderboard.$i": {
                  {"leaderboard.$i.rank": rank, "leaderboard.$i.userID": userID}
                }
              });
              // todo
              developer.log("rank>50 && myoldrank<=50");
            } else if (rank <= 50 && myoldrank <= 50) {
              //subtract 1 from everyone's ranks < myoldrank in the database then update myrank and myuserID into leaderboard then adds one to everyone's ranks < myrank

              for (int j = 0; j < leaderboard.length; j++) {
                if (leaderboard[j]["rank"] < myoldrank) {
                  FirebaseFirestore.instance
                      .collection("deck")
                      .doc(deckID)
                      .update({
                    "leaderboard.$j": {
                      "leaderboard.$j.rank": leaderboard[j]["rank"] - 1,
                      "leaderboard.$j.userID": userID
                    }
                  });
                }
                if (leaderboard[j]["rank"] < rank) {
                  FirebaseFirestore.instance
                      .collection("deck")
                      .doc(deckID)
                      .update({
                    "leaderboard.$j": {
                      "leaderboard.$j.rank": leaderboard[j]["rank"] + 1,
                      "leaderboard.$j.userID": userID
                    }
                  });
                }
              }
              FirebaseFirestore.instance.collection("deck").doc(deckID).update({
                "leaderboard.$i": {
                  {"leaderboard.$i.rank": rank, "leaderboard.$i.userID": userID}
                }
              });
              // todo NO USERID FOR SOME REASON
              developer.log(i.toString() + "rank<=50 && myoldrank<=50");
            }
            break;
          }

          // try {if (leaderboard[i] != null) {if (rank <= 50) {
          if (!userFound && rank <= 50 && leaderboard.length > 1) {
            // add 1 to everyone's ranks below myrank in the database then add myrank and myuserID into leaderboard
            for (int j = 0; j < leaderboard.length; j++) {
              if (leaderboard[j]["rank"] < rank) {
                FirebaseFirestore.instance
                    .collection("deck")
                    .doc(deckID)
                    .update({
                  "leaderboard.$j": {
                    {
                      "leaderboard.$j.rank": rank + 1,
                      "leaderboard.$j.userID": userID
                    }
                  }
                });
              }
            }
            //add new user to the leaderboard
            Map<String, dynamic> newUser = {"rank": rank, "userID": userID};
            FirebaseFirestore.instance.collection("deck").doc(deckID).update({
              "leaderboard": FieldValue.arrayUnion([newUser])
            });
            // todo
            developer.log("userfound and rank<=50");
          } else if ((!userFound && rank > 50) || leaderboard.length == 0) {
            // just add myrank and myuserID into leaderboard
            Map<String, dynamic> newUser = {"rank": rank, "userID": userID};
            FirebaseFirestore.instance.collection("deck").doc(deckID).update({
              "leaderboard": FieldValue.arrayUnion([newUser])
            });
            // todo
            developer.log("userfound and rank>50");
          }
        } catch (e) {
          developer.log(e.toString());
        }
      }
    }
  }
}
