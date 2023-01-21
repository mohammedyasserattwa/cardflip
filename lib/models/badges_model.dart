import 'dart:math';

import 'package:cardflip/data/badge.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/data/user.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/leaderboard_model.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cardflip/widgets/badges/badges.dart';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';

class BadgesModel {
  User currentUser;
  List<Badge> badges = [];
  DeckModel deckModel = DeckModel();
  final _badgeCollection = FirebaseFirestore.instance.collection("badge");
  UserModel userModel = UserModel();

  BadgesModel({required this.currentUser}) {
    try {
      _badgeCollection.get().then((snapshot) {
        for (var document in snapshot.docs) {
          if (document.data().isNotEmpty) {
            if (document.data()['achievements'] != null &&
                document.data()['achievements'].isNotEmpty) {
              var achievements = document.data()['achievements'];

              for (var achievementId in achievements.keys) {
                var newBadge = Badge(
                    id: document.data()['title'] + '-' + achievementId,
                    title: document.data()['title'],
                    frequency: document.data()['frequency'],
                    image: document.data()['image'],
                    description: achievements[achievementId]);
                badges.add(newBadge);
              }
            } else if (document.data()['frequency'] != null) {
              var newBadge = Badge(
                  id: document.data()['title'],
                  title: document.data()['title'],
                  frequency: document.data()['frequency'],
                  image: document.data()['image'],
                  description: document.data()['description']);
              badges.add(newBadge);
            }
          }
        }
      });
    } catch (e) {
      developer.log(e.toString());
    }
  }

  Future<bool> firstTimerTest() {
    return userModel.userDataByID(this.currentUser.id).then((user) async {
      if (user['badges']['firsttimer']['test'] != null) {
        if (user['badges']['firsttimer']['test'] == 0) {
          currentUser.badges['firsttimer']['test'] += 1;
          await userModel.updateUser(currentUser);
          return true;
        }
      }
      return false;
    });
  }

  Future<bool> firstOnLeaderboard(Deck deck) {
    return userModel.userDataByID(this.currentUser.id).then((user) async {
      return deckModel.leaderboardUsers(deck.id).then((value) async {
        for (var i = 0; i < value.length; i++) {
          if (value[i]['rank'] == 1 &&
              value[i]['userID'] == this.currentUser.id) {
            currentUser.badges['gold'] += 1;

            if (badges
                .where((element) => element.image == 'gold')
                .first
                .frequency
                .contains(user['badges']['gold'] + 1)) {
              await userModel.updateUser(currentUser);
              return true;
            }
          }
        }
        return false;
      });
    });
  }

  Future<bool> secondOnLeaderboard(Deck deck) {
    return userModel.userDataByID(this.currentUser.id).then((user) async {
      return deckModel.leaderboardUsers(deck.id).then((value) async {
        for (var i = 0; i < value.length; i++) {
          if (value[i]['rank'] == 2 &&
              value[i]['userID'] == this.currentUser.id) {
            currentUser.badges['silver'] += 1;

            if (badges
                .where((element) => element.image == 'silver')
                .first
                .frequency
                .contains(user['badges']['silver'] + 1)) {
              await userModel.updateUser(currentUser);
              return true;
            }
          }
        }
        return false;
      });
    });
  }

  Future<bool> thirdOnLeaderboard(Deck deck) {
    return userModel.userDataByID(this.currentUser.id).then((user) async {
      return deckModel.leaderboardUsers(deck.id).then((value) async {
        for (var i = 0; i < value.length; i++) {
          if (value[i]['rank'] == 3 &&
              value[i]['userID'] == this.currentUser.id) {
            currentUser.badges['bronze'] += 1;

            if (badges
                .where((element) => element.image == 'bronze')
                .first
                .frequency
                .contains(user['badges']['bronze'] + 1)) {
              await userModel.updateUser(currentUser);
              return true;
            }
          }
        }
        return false;
      });
    });
  }

  Future<bool> getFastestUser(Deck deck) async {
    if (this.currentUser.badges['fasttest'] == 0) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("testresults")
          .where("deckID", isEqualTo: deck.id)
          .get();
      var data = snapshot.docs;
      var durationList = <int, String>{};

      data.forEach((element) {
        if (element["missed"] != null && element["missed"].length == 0) {
          durationList[element["seconds"]] = element["userID"];
        }
      });
      if (durationList.length == 0) {
        return false;
      }
      var minDuration = durationList.keys.toList().reduce(min);
      var fastestUser = durationList[minDuration];
      if (fastestUser == this.currentUser.id) {
        currentUser.badges['fasttest'] += 1;
        await userModel.updateUser(currentUser);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<Map<String, bool>> testCheck(Deck deck) async {
    Map<String, bool> testCheck = {
      'First-Timer-test': false,
      'Champion': false,
      'Runner-Up': false,
      'Third Place Finisher': false,
      'Speed Racer': false
    };
    bool value = await firstTimerTest();
    testCheck['First-Timer-test'] = value;
    bool value2 = await firstOnLeaderboard(deck);
    testCheck['Champion'] = value2;
    bool value3 = await secondOnLeaderboard(deck);
    testCheck['Runner-Up'] = value3;
    bool value4 = await thirdOnLeaderboard(deck);
    testCheck['Third Place Finisher'] = value4;
    bool value5 = await getFastestUser(deck);
    testCheck['Speed Racer'] = value5;
    return testCheck;
  }

  get getCurrentUser => currentUser;
  get getBadges => badges;
}
