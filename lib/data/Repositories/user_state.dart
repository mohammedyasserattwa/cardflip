import 'package:cardflip/data/User.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:riverpod/riverpod.dart";

final UserModel userModel = UserModel();
final _userCollection = FirebaseFirestore.instance.collection("user");
final UserIDProvider = StateProvider<String>((ref) {
  return userModel.id;
});
final UserDataProvider = StateProvider<User>((ref) {
  return User(
    firstname: "Mohammed",
    lastname: "Yasser",
    email: "tester@gmail.com",
    password: "tester123",
    username: "testertester",
    profileIcon: "1",
  );
});
