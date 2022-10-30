//import 'dart:ffi';
// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/ProfileModel.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../widgets/navibar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: unnecessary_new
  ProfileModel model = new ProfileModel(new DummyData());
  CardGenerator cardgenerator = new CardGenerator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/profilepage.png"),
              fit: BoxFit.cover),
        ),
        child: Expanded(
          child: NoGlowScroll(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Stack(
                    children: [
                      Container(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/banners/profilepage/0.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 398,
                                  height: 190,
                                  child: Text(""))),
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(38, 45, 10, 10),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "Images/avatars/1.png"),
                                              fit: BoxFit.cover),
                                        ),
                                        width: 85,
                                        height: 85,
                                        child: Text(""))),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 50, 45, 10),
                              child: Container(
                                width:150,
                                child: AutoSizeText(
                                  "Omar Wael",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 12,
                                  stepGranularity: 1,
                                  maxLines:2,
                                  style: TextStyle(
                                    fontFamily: "PolySans_Median",
                                    color: Colors.black,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(19, 180, 10, 0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/editprofile.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 103,
                                  height: 34,
                                  child: Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "PolySans_Median"),
                                    ),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                  child: Text(
                    "Badges",
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/badges1.png"),
                              fit: BoxFit.cover),
                        ),
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/badges2.png"),
                              fit: BoxFit.cover),
                        ),
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/badges3.png"),
                              fit: BoxFit.cover),
                        ),
                        height: 50,
                        width: 50,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/morebadges.png"),
                              fit: BoxFit.cover),
                        ),
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Text(
                            "+32",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: Text(
                    "Recent Decks",
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 21,
                      color: Color(0xff212523),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
                  child: SizedBox(
                    height: 116.67,
                    child: NoGlowScroll(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          SizedBox(width: 13),
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          SizedBox(width: 13),
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: Text("Top Rated Decks",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 21,
                          color: Color(0xff212523))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
                  child: SizedBox(
                    height: 116.67,
                    child: NoGlowScroll(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          SizedBox(width: 13),
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          SizedBox(width: 13),
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 35, 0, 0),
                  child: Text("Leaderboard",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 21,
                          color: Color(0xff212523))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 2, 10),
                  child: SizedBox(
                    height: 116.67,
                    child: NoGlowScroll(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          SizedBox(width: 13),
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                          SizedBox(width: 13),
                          Deck(
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Deck extends StatelessWidget {
  const Deck({
    Key? key,
    required this.cardgenerator,
    required this.height,
    required this.width,
    required this.path,
  }) : super(key: key);

  final CardGenerator cardgenerator;
  final double height;
  final double width;
  final String path;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        ),
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/star.png"),
                              fit: BoxFit.cover),
                        ),
                        width: 15,
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${cardgenerator.rating}",
                          style: TextStyle(
                            fontFamily: "PolySans_Neutral.ttf",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2D2D2D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/more.png"),
                            fit: BoxFit.cover),
                      ),
                      width: 21,
                      height: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Flexible(
                child: AutoSizeText(
                  cardgenerator.deck,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 12,
                  stepGranularity: 1,
                  style: TextStyle(
                    fontFamily: "Poppins-SemiBold",
                    color: Color(0xff131414).withOpacity(0.6),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
