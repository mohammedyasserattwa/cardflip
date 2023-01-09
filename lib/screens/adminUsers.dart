//import 'dart:ffi';
// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/main.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/widgets/deck.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/ProfileModel.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../models/adminModel.dart';
import '../widgets/admin_deck.dart';
import '../widgets/navibar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AdminUsers extends StatelessWidget {
  AdminUsers({key});

  AdminModel model = AdminModel();

  DeckModel deckModel = DeckModel();
  CardGenerator cardgenerator = CardGenerator();
  late String profileBanner;

  // _responsive(BuildContext context) {
  //   if (MediaQuery.of(context).size.width < 299) {
  //     return {"height": 113.67, "width": 118.67, "fontSize": 16};
  //   } else if (MediaQuery.of(context).size.width < 340) {
  //     return {"height": 128.67, "width": 133.67, "fontSize": 20};
  //   } else if (MediaQuery.of(context).size.width < 358) {
  //     return {"height": 148.67, "width": 153.67, "fontSize": 20};
  //   } else {
  //     return {"height": 158.67, "width": 163.67, "fontSize": 20};
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final userData = model.userDataList();
    final height = 128.67;
    final width = 133.67;
    return Scaffold(
      body: Container(
        height: 1000,
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
                  GestureDetector(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onTap: () {
                      Navigator.pushNamed(context, "/admin");
                    },
                    child: Text(
                      "Decks",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Color.fromARGB(99, 98, 102, 100),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 63,
                  height: 31,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromARGB(100, 124, 120, 120),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "All",
                      style: TextStyle(
                        fontFamily: "PolySans_Slim",
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Banned",
                    style: TextStyle(
                      fontFamily: "PolySans_Slim",
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Normal",
                    style: TextStyle(
                      fontFamily: "PolySans_Slim",
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/search.png"),
                              fit: BoxFit.cover),
                        ),
                        width: 40,
                        height: 40,
                        child: const Text(""))),
              ],
            ),
            FutureBuilder(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: NoGlowScroll(
                        child: ListView(
                          children: [
                            for (var i = 0; i < snapshot.data!.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                            "Images/avatars/${snapshot.data![i]["profileIcon"]}.svg",
                                            width: 50,
                                            height: 50),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data![i]["fname"]} ${snapshot.data![i]["lname"]}",
                                              style: TextStyle(
                                                fontFamily: "PolySans_Slim",
                                                color: Color(0xf0493C3F),
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "@${snapshot.data![i]["username"]}",
                                              style: TextStyle(
                                                fontFamily: "PolySans_Slim",
                                                color: Color(0xf0493C3F),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "Images/icons/ban.png"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: Text("")),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "Images/icons/arrow-right-s-line.png"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: Text("")),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
