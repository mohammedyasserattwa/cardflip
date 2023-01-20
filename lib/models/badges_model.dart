import 'package:cardflip/data/badge.dart';
import 'package:cardflip/data/user.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cardflip/widgets/badges/badges.dart';
import 'dart:developer' as developer;

// (1st)
// completed first test (TEST PAGE)
// studied 1st deck till end (FLASHCARDS PAGE)
// created first deck (CREATE DECK PAGE)

// (1st,10th,30th,50th,80th,100th,500,1000)
// first on the leaderboard lw fe 5 (TEST PAGE)
// second on the leaderboard same lw fe 5 (TEST PAGE)
// third … (TEST PAGE)
// time fast compared to q no (TEST PAGE)
// 1 q in 10 secs msln?
// fastest on the leaderboard lw 5ls till the end (TEST PAGE)

// (10,50,100,250,500,1000)
// deck hit _ likes (THEIR DECK PAGE)(25/50/150/100/200/300/400/500/1000)
// _ competing in your deck’s leaderboard (TEST)
// hosting
// added _ decks to library (DECK PAGE)
// created _ decks (CREATE DECK PAGE)

class BadgesModel {
  User currentUser;
  List<Badge> badges = [];
  final _badgeCollection = FirebaseFirestore.instance.collection("badge");
  UserModel userModel = UserModel();

  BadgesModel({required this.currentUser}) {
    try {
      _badgeCollection.get().then((snapshot) {
        for (var document in snapshot.docs) {
          if (document.data().isNotEmpty) {
            var achievements = document.data()['achievements'];
            for (var achievementId in achievements.keys) {
              var newBadge = Badge(
                  id: document.id + '-' + achievementId,
                  title: document.data()['title'],
                  frequency: document.data()['frequency'],
                  image: document.data()['image'],
                  description: achievements[achievementId]);
              badges.add(newBadge);
            }
          }
        }
      });
    } catch (e) {
      developer.log(e.toString());
    }
  }

  bool firstTimerDeck() {
    userModel.userDataByID(this.currentUser.id).then((user) async {
      if (user['badges']['firsttimer']['deck'].isNotEmpty) {
        if (user['badges']['firsttimer']['deck'] == 0) {
          currentUser.badges['firsttimer']['deck'] += 1;
          await userModel.updateUser(currentUser);
          return true;
        }
      }
    });
    return false;
  }

  bool firstTimerCreate() {
    userModel.userDataByID(this.currentUser.id).then((user) async {
      if (user['badges']['firsttimer']['test'].isNotEmpty) {
        // add badge to user
        if (user['badges']['firsttimer']['test'] == 0) {
          currentUser.badges['firsttimer']['test'] += 1;
          await userModel.updateUser(currentUser);
          return true;
        }
      }
    });
    return false;
  }

  bool firstTimerTest() {
    userModel.userDataByID(this.currentUser.id).then((user) async {
      if (user['badges']['firsttimer']['test'].isNotEmpty) {
        if (user['badges']['firsttimer']['test'] == 0) {
          currentUser.badges['firsttimer']['test'] += 1;
          await userModel.updateUser(currentUser);
          return true;
        }
      }
    });
    return false;
    // Badge badge = badges.where((title) => title == 'firsttimer').toList()[0];
    // _badgeCollection.doc(badge.id).get().then((snapshot) {
    //   if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
    //     if ((snapshot.data() as Map<String, dynamic>)['frequency'] == 1) {
    //       return false;
    //     } else {
    //       return true;
    //     }
    //   }
    // });
  }

  testCheck(context) {
    if (firstTimerTest()) {
      Navigator.pushNamed(context, '/badges',
          arguments: {"badgeIndex": 'firsttimer-test'});
    }
    // other test checks
  }

  flashcardsCheck(context) {
    if (firstTimerDeck()) {
      Navigator.pushNamed(context, '/badges',
          arguments: {"badgeIndex": 'firsttimer-flashcards'});
    }
  }

  createCheck(context) {
    if (firstTimerCreate()) {
      Navigator.pushNamed(context, '/badges',
          arguments: {"badgeIndex": 'firsttimer-createdeck'});
    }
    // other create checks
  }

  // call right functions in each page
  // functions for each page bt call all the function
  // to check kol el badges related to pages
  // check if user already has it (since last),
  // then if frequency is right in each page if yes
  // check each achievement unlocked if yes,
  // adds in database update frequency milestone
  // then returns pop up from BadgePopUp (context?/scaffoldof)

  get getBadges => badges;
}
