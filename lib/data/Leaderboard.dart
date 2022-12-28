import 'package:cardflip/data/User.dart';

class Leaderboard {
  late List<User> leaderboardlist;
  String deckID;
  Leaderboard({
    this.deckID = "1",
  }) {
    leaderboardlist = [
      User(
          firstname: "Lara",
          lastname: "Croft",
          email: "laracroft@gmail.com",
          password: "123456",
          username: "laracroft",
          profileIcon: "Images/avatars/1.png",
          id: "01f4bll6"),
      User(
          firstname: "Khalid",
          lastname: "Almalki",
          email: "khalid@gmail.com",
          password: "123456",
          username: "khalid",
          profileIcon: "Images/avatars/2.png",
          id: "01f4bll7"),
      User(
          firstname: "Yasser",
          lastname: "Mansour",
          email: "yasser@gmail.com",
          password: "123456",
          username: "yasser",
          profileIcon: "Images/avatars/3.png",
          id: "01f4bll8"),
      User(
          firstname: "Omar",
          lastname: "Dahdouh",
          email: "omar@gmail.com",
          password: "123456",
          username: "omar",
          profileIcon: "Images/avatars/4.png",
          id: "01f4bll9")
    ];
  }
  List<User> get leaderboardList => leaderboardlist;
}
