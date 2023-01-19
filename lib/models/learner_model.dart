import 'package:cardflip/data/badges.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/models/badges_model.dart';
import 'package:cardflip/data/badges.dart';

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
