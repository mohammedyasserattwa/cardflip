import 'dart:collection';

import 'package:cardflip/data/User.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/user_model.dart';
import "dart:developer" as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardModel {
  // String id;
  // late Leaderboard leaderboard;
  final _deckCollection = FirebaseFirestore.instance.collection("deck");

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
      usersInfo.add(await userModel.getNameandPic(data[i]!['userID']));

      ranks.add((data[i]!['rank']));
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

  Future updateLeaderboard(int percentage, int time, String userID,
      dynamic testCollection, String deckID) async {
    int rank = 1;

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _deckCollection.doc(deckID).get();

    Query rankCalc = testCollection
        .where('deckID', isEqualTo: deckID)
        .where('percentage', isGreaterThanOrEqualTo: percentage)
        .orderBy('percentage', descending: true)
        .orderBy('seconds', descending: false);

    QuerySnapshot snapshot4 = await rankCalc.get();
    if (snapshot4.docs.isNotEmpty) {
      for (var i = 0; i < snapshot4.docs.length; i++) {
        developer.log(snapshot4.docs[i].data().toString());
        if ((snapshot4.docs[i].data() as Map<String, dynamic>)['percentage'] ==
                percentage &&
            (snapshot4.docs[i].data() as Map<String, dynamic>)['seconds'] ==
                time) {
          rank += i;
          break;
        } else if ((snapshot4.docs[i].data()
                    as Map<String, dynamic>)['percentage'] ==
                percentage &&
            (snapshot4.docs[i].data() as Map<String, dynamic>)['seconds'] <
                time) {
          rank += i + 1;
          break;
        } else if ((snapshot4.docs[i].data()
                as Map<String, dynamic>)['percentage'] <
            percentage) {
          rank += i + 1;
          break;
        }
      }
    }
    if (snapshot['leaderboard'].isEmpty) {
      rank = 1;
    }

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("deck").doc(deckID).get();

    if (doc.exists) {
      var leaderboard = (doc.data() as Map<String, dynamic>)["leaderboard"];
      if (leaderboard.length == 0) {
        Map<String, dynamic> newUser = {"rank": 1, "userID": userID};
        await FirebaseFirestore.instance.collection("deck").doc(deckID).update({
          "leaderboard": FieldValue.arrayUnion([newUser])
        });
      } else {
        bool userFound = false;
        int myoldrank = 0;
        int index = 0;
        for (int i = 0; i < leaderboard.length; i++) {
          if (leaderboard[i] != null && leaderboard[i]["userID"] == userID) {
            userFound = true;
            myoldrank = leaderboard[i]["rank"];
            index = i;
            break;
          }
        }
        if (userFound) {
          if (leaderboard.length == 1) {
            rank = 1;
          }
          if (rank > 50) {
            FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot5 = await transaction.get(doc.reference);
              List<dynamic> leaderboard =
                  (snapshot5.data() as Map<String, dynamic>)['leaderboard'];
              if (myoldrank <= 50) {
                for (int j = 0; j < leaderboard.length; j++) {
                  if (j != index && leaderboard[j]["rank"] < myoldrank) {
                    leaderboard[j]["rank"] = leaderboard[j]["rank"] - 1;
                  }
                }
              }
              leaderboard[index]["rank"] = rank;
              leaderboard[index]["userID"] = userID;
              transaction.update(doc.reference, {"leaderboard": leaderboard});
            });
          } else if (rank <= 50) {
            developer.log(rank.toString());
            developer.log(myoldrank.toString());
            FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot5 = await transaction.get(doc.reference);
              List<dynamic> leaderboard =
                  (snapshot5.data() as Map<String, dynamic>)['leaderboard'];
              if (myoldrank < rank) {
                for (int j = 0; j < leaderboard.length; j++) {
                  if (j != index) {
                    if (leaderboard[j]["rank"] > myoldrank) {
                      leaderboard[j]["rank"] = leaderboard[j]["rank"] - 1;
                    }
                    if (leaderboard[j]["rank"] >= rank) {
                      leaderboard[j]["rank"] = leaderboard[j]["rank"] + 1;
                    }
                  }
                }
              } else if (myoldrank > rank) {
                for (int j = 0; j < leaderboard.length; j++) {
                  if (j != index) {
                    if (leaderboard[j]["rank"] >= rank &&
                        leaderboard[j]["rank"] < myoldrank) {
                      leaderboard[j]["rank"] = leaderboard[j]["rank"] + 1;
                    }
                  }
                }
              }
              leaderboard[index]["rank"] = rank;
              leaderboard[index]["userID"] = userID;
              transaction.update(doc.reference, {"leaderboard": leaderboard});
            });
          }
        } else if (!userFound && rank <= 50) {
          FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot snapshot5 = await transaction.get(doc.reference);
            var leaderboard =
                (snapshot5.data() as Map<String, dynamic>)['leaderboard'];
            for (int j = 0; j < leaderboard.length; j++) {
              if (leaderboard[j]["rank"] >= rank) {
                leaderboard[j]["rank"] = leaderboard[j]["rank"] + 1;
              }
            }
            leaderboard.add({"rank": rank, "userID": userID});
            transaction.update(doc.reference, {"leaderboard": leaderboard});
          });
        }
      }
    }
  }
}
