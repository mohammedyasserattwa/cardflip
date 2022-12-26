import "package:cardflip/data/dummy_data.dart";
import "package:cardflip/data/Badges.dart";

class BadgesModel {
  double? score;
  int? time;
  final List<Badges> badges = [
    Badges(
        name: "cardfliper",
        //image:fromdatabasewhenitisdone
        description: "for completing your first quiz on cardFlip"),
    Badges(
        name: "champion",
        //image:fromdatabasewhenitisdone
        description: "for scoring 100 points"),
    Badges(
        name: "striver",
        //image:fromdatabasewhenitisdone
        description: "for scoring 100 points in less than a minute"),
    Badges(
        name: "genius",
        //image:fromdatabasewhenitisdone
        description: "for scoring 200 points in less than a minute"),
    Badges(
        name: "the og cardfliper",
        //image:fromdatabasewhenitisdone
        description: "for scoring 1000 points")
  ];
  conditions(name) {
    if (time == 60) {
      return badges[0];
    } else if (score == 100) {
      return badges[1];
    } else if (score == 100 && time! < 60) {
      return badges[2];
    } else if (score == 200 && time! < 60) {
      return badges[3];
    } else if (score == 1000) {
      return badges[4];
    }
  }
}
