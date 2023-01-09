import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/dummy_data.dart';

class AdminModel {
  String username = "admin";
  String password = "cardFlip12345";
  String name = "Admin";
  List<String> reports = [];
  List<String> decks = [];
  List<String> users = [];

  final _userCollection = FirebaseFirestore.instance.collection("user");

  Future<List> userDataList() async {
    QuerySnapshot querySnapshot = await _userCollection
        .where(
          "role",
          isEqualTo: "learner",
        )
        .get();
    final data = querySnapshot.docs
        .map((doc) => {
              "fname": doc.get("fname"),
              "lname": doc.get("lname"),
              "profileIcon": doc.get("profileIcon"),
              "username": doc.get("username"),
              "banned": doc.get("banned")
            })
        .toList();
    return data;
  }

  void banUser() {
    // _userCollection.doc.set("true");
  }

  void banDeck(String name) {
    decks.remove(name);
  }

  void viewReports() {
    for (var i = 0; i < reports.length; i++) {
      print(reports[i] + '\n');
    }
  }

  void viewDecks() {
    for (var i = 0; i < decks.length; i++) {
      print(decks[i] + '\n');
    }
  }

  void viewUsers() {
    for (var i = 0; i < users.length; i++) {
      print(users[i] + '\n');
    }
  }
}
