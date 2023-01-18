import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/card.dart';
import '../data/category.dart';
import '../data/deck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:developer" as developer;
import "../data/User.dart" as user_data;

class UserModel {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection("user");

  save(User user, Map<String, dynamic> data) async {
    final userRef = _database.collection("user").doc(user.uid);
    if (!(await userRef.get()).exists) {
      await userRef.set(data);
    }
  }

  Future<List<dynamic>> userByQuery(String query) async {
    QuerySnapshot querySnapshot = await _userCollection.get();
    final usersData = querySnapshot.docs
        .map((doc) => {
              "fname": doc.get("fname"),
              "lname": doc.get("lname"),
              "profileIcon": doc.get("profileIcon"),
              "username": doc.get("username")
            })
        .toList();
    // developer.log(data.toString());
    List result = [];
    for (int i = 0; i < usersData.length; i++) {
      // developer.log(usersData[i]["fname"]);
      // developer.log(
      //     "${usersData[i]["fname"]} != $query || ${usersData[i]["fname"].trim().toLowerCase().contains(query.trim().toLowerCase())}");
      if (usersData[i]["role"] != "admin") {
        if ("${usersData[i]["fname"]} ${usersData[i]["lname"]}}"
                .trim()
                .toLowerCase()
                .contains(query.trim().toLowerCase()) ||
            usersData[i]["fname"]
                .trim()
                .toLowerCase()
                .contains(query.trim().toLowerCase()) ||
            usersData[i]["lname"]
                .trim()
                .toLowerCase()
                .contains(query.trim().toLowerCase()) ||
            usersData[i]["username"]
                .trim()
                .toLowerCase()
                .contains(query.trim().toLowerCase())) {
          // developer.log(usersData[i]["fname"]);
          result.add(usersData[i]);
        }
      }

      // if (
      //     //   data[i]["username"].compareTo(query) != 0
      //     // &&
      //     usersData[i]["fname"]
      //             .trim()
      //             .toLowerCase()
      //             .contains(query.trim().toLowerCase()) ==
      //         true
      //     // &&
      //     // data[i]["lname"].compareTo(query) != 0
      //     ) {
      //   developer.log(
      //       "${usersData[i]["fname"]} != $query || ${usersData[i]["fname"].trim().toLowerCase().contains(query.trim().toLowerCase())}");
      //   continue;
      // }
      // usersData.remove(usersData[i]);
    }
    // print(data);
    return result;
  }

  Future userByID(String ID) async {
    var querySnapshot = await _userCollection.doc(ID).get();
    Map<String, dynamic> usersData =
        querySnapshot.data() as Map<String, dynamic>;
    return usersData;
  }

  Future getNameandPic(String ID) async {
    var querySnapshot = await _userCollection.doc(ID).get();
    Map usersData = {
      "profileIcon": querySnapshot.get("profileIcon"),
      "fname": querySnapshot.get("fname"),
      "lname": querySnapshot.get("lname"),
      "ID": ID,
    };
    return usersData;
  }

  Future<List> usernameList() async {
    QuerySnapshot querySnapshot = await _userCollection.get();
    final data = querySnapshot.docs.map((doc) => doc.get("username")).toList();
    return data;
  }

  Future<List> emailList() async {
    QuerySnapshot querySnapshot = await _userCollection.get();
    final data = querySnapshot.docs.map((doc) => doc.get("email")).toList();
    return data;
  }

  Future<Map> getUserByID(String docID) async {
    final user = await _userCollection.doc(docID).get();
    return {
      "id": user.id,
      "username": user["username"],
      "email": user["email"],
      "fname": user["fname"],
      "lname": user["lname"],
      "profileIcon": user["profileIcon"]
    };
  }

  Future resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Container();
      } else {
        return Container();
      }
    }
  }

  signOut() async {
    await _auth.signOut();
  }

  String get id {
    final user = _auth.currentUser!;
    return user.uid;
  }

  Future<DocumentSnapshot> get userData {
    final user = _auth.currentUser!;
    String id = user.uid;
    // String name;
    return _userCollection.doc(id).get();
    // name = userDoc.get("fname");
    // return name;
  }

  final List<String> _cardBackgrounds = [
    "Images/cards/flashcards/2.png",
    "Images/cards/flashcards/1.png",
    "Images/cards/flashcards/0.png",
  ];
  List<String> get getImages => _cardBackgrounds;
  // ignore: todo
  // TODO: Get the user document ID
  // ignore: todo
  // TODO: Get the user personal Information
  // ignore: todo
  // TODO: Get the user favourite decks
  // Get the user chosen Categories

  // TODO: Get the user badges
  // TODO: Get the user created decks
  // TODO: Local Database to get previously left over decks

}
