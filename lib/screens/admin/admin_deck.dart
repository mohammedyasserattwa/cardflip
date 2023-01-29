//import 'dart:ffi';
// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'package:cardflip/helpers/random_generator.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../../models/admin_model.dart';
import '../../widgets/admin/admin_deck.dart';


class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  // TODO: REMOVE the profile model with the UserModel
  AdminModel model = AdminModel();

  // TODO: ADD the leaderboard model here
  DeckModel deckModel = DeckModel();

  RandomGenerator cardgenerator = RandomGenerator();

  late String profileBanner;

  // _responsive(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    final deckData = model.deckDataList();
    final height = 128.67;
    final width = 133.67;
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/dashboardpage.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/settings");
                      },
                      child: SvgPicture.asset(
                        "Images/icons/svg/settings.svg",
                        width: 25,
                        height: 25,
                        color: Color(0xff8C9595),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 30),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "Images/avatars/logo/playstore (1) 1.png"),
                            fit: BoxFit.cover),
                      ),
                      width: 85,
                      height: 85,
                      child: Text("")),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      "Dashboard ",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color(0xf0493C3F),
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Decks",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/adminUsers");
                    },
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color.fromARGB(99, 98, 102, 100),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/adminReports");
                    },
                    child: Text(
                      "Reports",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color.fromARGB(99, 98, 102, 100),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: deckData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: NoGlowScroll(
                        child: ListView(
                          children: [
                            for (int i = 0; i < snapshot.data!.length; i += 2)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      (i + 1 < snapshot.data!.length)
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.start,
                                  children: [
                                    AdminDeck(
                                      width: 139,
                                      height: 116.67,
                                      deck: snapshot.data![i],
                                      path:
                                          "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                      min: 2,
                                      onTap: () {},
                                    ),
                                    if (i + 1 < snapshot.data!.length)
                                      AdminDeck(
                                        width: 139,
                                        height: 116.67,
                                        deck: snapshot.data![i + 1],
                                        path:
                                            "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                        min: 2,
                                        onTap: () {},
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) return Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff484848),
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "PolySans_Neutral"),
                                                           "Something went wrong.");
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
