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
          profileIcon: "Images/avatars/0.svg",
          id: "01f4bll6"),
      User(
          firstname: "Khalid",
          lastname: "Almalki",
          email: "khalid@gmail.com",
          password: "123456",
          username: "khalid",
          profileIcon: "Images/avatars/1.svg",
          id: "01f4bll7"),
      User(
          firstname: "Yasser",
          lastname: "Mansour",
          email: "yasser@gmail.com",
          password: "123456",
          username: "yasser",
          profileIcon: "Images/avatars/2.svg",
          id: "01f4bll8"),
      User(
          firstname: "Omar",
          lastname: "Dahdouh",
          email: "omar@gmail.com",
          password: "123456",
          username: "omar",
          profileIcon: "Images/avatars/3.svg",
          id: "01f4bll9"),
      User(
        firstname: "Ahmed",
        lastname: "Elshafei",
        email: "ahmed@gmail.com",
        password: "123456",
        username: "ahmed",
        profileIcon: "Images/avatars/4.svg",
        id: "01f4bll10",
      ),
      User(
        firstname: "Mohammed",
        lastname: "Badr",
        email: "badr@gmail.com",
        password: "123456",
        username: "badr",
        profileIcon: "Images/avatars/5.svg",
        id: "01f4bll11",
      ),
      User(
        firstname: "Emad",
        lastname: "Omar",
        email: "emad@gmail.com",
        password: "123456",
        username: "emad",
        profileIcon: "Images/avatars/6.svg",
        id: "01f4bll12",
      ),
      User(
        firstname: "Nour",
        lastname: "Ahmed",
        email: "nour@gmail.com",
        password: "123456",
        username: "nour",
        profileIcon: "Images/avatars/7.svg",
        id: "01f4bll13",
      ),
      User(
        firstname: "Jana",
        lastname: "Jamal",
        email: "jana@gmail.com",
        password: "123456",
        username: "jana",
        profileIcon: "Images/avatars/8.svg",
        id: "01f4bll14",
      ),
      User(
        firstname: "Dina",
        lastname: "Ali",
        email: "dina@gmail.com",
        password: "123456",
        username: "dina",
        profileIcon: "Images/avatars/9.svg",
        id: "01f4bll15",
      )
    ];
  }
  List<User> get leaderboardList => leaderboardlist;
}
