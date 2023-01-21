import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import "dart:developer" as developer;
import '../data/user.dart' as user_data;

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
    QuerySnapshot querySnapshot =
        await _userCollection.where("role", isNotEqualTo: "admin").get();
    final usersData = querySnapshot.docs
        .map((doc) => {
              "fname": doc.get("fname"),
              "id": doc.id,
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
    }
    return result;
  }

  Future<List<String>> getBadgesKeys(String id) async {
    final querySnapshot = await _userCollection.doc(id).get();
    print(querySnapshot.get("badges"));
    final data = querySnapshot.get("badges") as Map<String, dynamic>;
    List<String> badges = [];

    data.forEach((String k, dynamic e) {
      // int n =
      if (k == "firsttimer") {
        e = e["test"];
      }
      if (e != 0) {
        badges.add((k == "firsttimer") ? "firsttimer" : k);
      }
    });

    // for () {
    // for (int j = 0; j < data[i].length; j++) {
    // badges.add(data[i]);
    // }
    // }
    return badges;
  }

  Future userDataByID(String id) async {
    var querySnapshot = await _userCollection.doc(id).get();
    Map<String, dynamic> usersData =
        querySnapshot.data() as Map<String, dynamic>;
    usersData.addAll({"id": querySnapshot.id});
    return usersData;
  }

  Future editCredentials(String email, String password) async {
    final user = _auth.currentUser!;
    await user.updateEmail(email);
    await user.updatePassword(password);
  }

  Future getNameandPic(String id) async {
    var querySnapshot = await _userCollection.doc(id).get();
    Map usersData = {
      "profileIcon": querySnapshot.get("profileIcon"),
      "fname": querySnapshot.get("fname"),
      "lname": querySnapshot.get("lname"),
      "ID": id,
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
    final userData = await _userCollection.doc(docID).get();
    return {
      "id": docID,
      "username": userData["username"],
      "email": userData["email"],
      "fname": userData["fname"],
      "lname": userData["lname"],
      "profileIcon": userData["profileIcon"]
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

  Future updateUser(user_data.User updatedUser) {
    return _userCollection.doc(updatedUser.id).update(updatedUser.toJSON());
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
  Future updateFavourites(List<String> favourites, user_data.User currentUser) {
    currentUser.favourites = favourites;
    return _userCollection.doc(currentUser.id).update(currentUser.toJSON());
  }
}
