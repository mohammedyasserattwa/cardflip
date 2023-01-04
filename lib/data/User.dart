// ignore_for_file: unnecessary_this, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  //CONSTRUCTOR
  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.username,
    required this.profileIcon,
    required this.id,
    this.role = "learner",
    this.favourites = const [],
    this.badges = const [],
  });
  User.New() {
    firstname = "";
    lastname = "";
    email = "";
    password = "";
    username = "";
    profileIcon = "0";
    id = "";
    role = "learner";
  }
  factory User.fromSnapshot(
      DocumentSnapshot snapshot, String email, String password, String id) {
    String firstname = snapshot.get("fname");
    String lastname = snapshot.get("lname");
    String username = snapshot.get("username");
    String profileIcon = snapshot.get("profileIcon");
    return User(
        firstname: firstname,
        lastname: lastname,
        username: username,
        profileIcon: profileIcon,
        id: id,
        email: email,
        password: password);

    // this.
  }
  Map<String, dynamic> toJSON() {
    return {
      "email" : email,
      "fname" : firstname,
      "lname" : lastname,
      "username" : username,
      "profileIcon" : profileIcon,
      "role" : role,
      "badges" : badges,
      "favourites" : favourites,
    };
  }

  //PARAMETERS
  late String firstname;
  late String id;
  late String lastname;
  late String email;
  late String username;
  late String password;
  late String profileIcon;
  late String role;
  List favourites = [];

  // List _reminders;
  List badges = [];
  List tags = [];

  //SETTER & GETTERS
  get userID => id;
  setuserID(id) => this.id = id;

  get icon => profileIcon;
  seticon(icon) => profileIcon = icon;

  get user => username;
  setuser(username) => this.username = username;

  get fname => this.firstname;
  setfname(value) => this.firstname = value;

  get lname => this.lastname;
  setlname(value) => this.lastname = value;

  get getEmail => email;
  setEmail(email) => this.email = email;

  get userTags => tags;
  setUserTags(tags) => this.tags = tags;

  get getPassword => password;
  setPassword(password) => this.password = password;

  get getUserName => this.username;
  setUsername(username) => this.username = username;

  get Badges => this.badges;
  setBadges(value) => this.badges = value;
}
