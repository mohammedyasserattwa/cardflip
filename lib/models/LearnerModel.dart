import 'package:cardflip/data/Badges.dart';
import "package:cardflip/data/dummy_data.dart";
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/models/BadgesModel.dart';
import "package:cardflip/data/Badges.dart";

class Learner {
  String username = "salmaCS";
  String firstname = "salma";
  String lastname = "helmi";
  String name = "learner";
  //List<List<Badges>> badges = [];
  List<String> Badges = [];
  void deletebadges(String name) {
    Badges.remove(name);
  }

  void addbadges(String name) {
    Badges.add(name);
  }

  void viewbadges() {
    for (var i = 0; i < Badges.length; i++) {
      print(Badges[i] + '\n');
    }
  }
}
