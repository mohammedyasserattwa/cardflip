import 'package:cardflip/data/User.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:riverpod/riverpod.dart";

final UserDataProvider = StateProvider<User?>((ref) {
  return null;
});
