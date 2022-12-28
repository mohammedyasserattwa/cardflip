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
  //PARAMETERS
  String firstname;
  String id;
  String lastname;
  String email;
  String username;
  String password;
  String profileIcon;
  List favourites = [];
  String role;
  // List _reminders;
  List badges = [];

  //SETTER & GETTERS
  get fname => firstname;
  set fname(value) => this.firstname = value;

  get lname => this.lastname;
  set lname(value) => this.lastname = value;

  get getEmail => email;
  set setEmail(email) => this.email = email;

  get getPassword => password;
  set setPassword(password) => this.password = password;

  get Badges => this.badges;
  set Badges(value) => this.badges = value;
}
