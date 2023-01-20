// ignore_for_file: unnecessary_this, file_names, non_constant_identifier_names

import 'package:cardflip/data/deck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  bool isBanned = false;

  //CONSTRUCTOR
  User(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.username,
      required this.profileIcon,
      required this.id,
      this.isBanned = false,
      this.role = "learner",
      this.favourites = const [],
      this.badges = const {},
      this.tags = const [],
      this.userPreferences = const []});
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
  factory User.fromSnapshot(DocumentSnapshot snapshot, String email,
      String password, String id, List<Deck> preferences) {
    String firstname = snapshot.get("fname");
    String lastname = snapshot.get("lname");
    String username = snapshot.get("username");
    String profileIcon = snapshot.get("profileIcon");
    List tags = snapshot.get("tags");
    Map badges =
        (snapshot.get("role") != 'admin') ? snapshot.get("badges") : {};

    return User(
        firstname: firstname,
        lastname: lastname,
        username: username,
        profileIcon: profileIcon,
        id: id,
        email: email,
        isBanned: snapshot.get("banned"),
        tags: tags,
        badges: badges,
        userPreferences: preferences,
        password: password,
        role: snapshot.get("role"));

    // this.
  }
  Map<String, dynamic> toJSON() {
    return {
      "email": email,
      "fname": firstname,
      "lname": lastname,
      "username": username,
      "profileIcon": profileIcon,
      "role": role,
      "badges": badges,
      "tags": tags,
      "banned": isBanned,
      "favourites": favourites,
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
  List tags = [];
  List userPreferences = [];

  // List _reminders;
  Map badges = {};

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
