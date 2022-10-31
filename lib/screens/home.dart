// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:ffi';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/screens/DeckScreen.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/homeModel.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../widgets/deck.dart';
import '../screens/category.dart';
import '../widgets/navibar.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeModel model = new HomeModel(new DummyData());
  CardGenerator cardgenerator = new CardGenerator();
  CardGenerator cardgenerator2 = new CardGenerator();
  CardGenerator cardgenerator3 = new CardGenerator();
  final navItems = {"Home", "Library", "Account"};
  final navIcons = {
    const Icon(Icons.home_rounded),
    const Icon(Icons.library_books_outlined),
    const Icon(Icons.person_outline)
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/homepage.png"),
              fit: BoxFit.cover),
        ),
        child: NoGlowScroll(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 19, 0, 0),
                child: Stack(
                  children: [
                    Container(
                      child: Text(
                        "Explore",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "PolySans_Median",
                          color: Color(0xff514F55),
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("Images/icons/search.png"),
                                      fit: BoxFit.cover),
                                ),
                                width: 48,
                                height: 48,
                                child: Text(""))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 14, 0, 0),
                child: Text(
                  "Welcome back, ${model.fname}",
                  style: TextStyle(
                    fontFamily: "PolySans_Median",
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: Text(
                  "Pick up where you left off",
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
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 10),
                          itemCount: 3,
                          itemBuilder: (context, index) => Deck(
                              onTap: () {
<<<<<<< Updated upstream
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DeckScreen()));
=======
                                GoRouter.of(context).go('/Deck');
>>>>>>> Stashed changes
                              },
                              cardgenerator: cardgenerator,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                              min: 3))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: Text("Based on what you like..",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 21,
                        color: Color(0xff212523))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
                child: SizedBox(
                  height: 236,
                  child: NoGlowScroll(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Deck(
                                  onTap: () {},
                                  cardgenerator: cardgenerator2,
                                  width: 125.04,
                                  height: 103.8,
                                  path:
                                      "Images/cards/homepage/2/2_1/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                  min: 2),
                              Deck(
                                  onTap: () {},
                                  cardgenerator: cardgenerator2,
                                  width: 125.04,
                                  height: 125.1,
                                  path:
                                      "Images/cards/homepage/2/2_4/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                  min: 3),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Deck(
                                  onTap: () {},
                                  cardgenerator: cardgenerator2,
                                  width: 128.54,
                                  height: 140.18,
                                  path:
                                      "Images/cards/homepage/2/2_2/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                  min: 3),
                              Deck(
                                  onTap: () {},
                                  cardgenerator: cardgenerator2,
                                  width: 128.54,
                                  height: 84.29,
                                  path:
                                      "Images/cards/homepage/2/2_5/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                  min: 1),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Deck(
                                onTap: () {},
                                cardgenerator: cardgenerator2,
                                width: 125.04,
                                height: 103.8,
                                path:
                                    "Images/cards/homepage/2/2_1/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                min: 2),
                            Deck(
                                onTap: () {},
                                cardgenerator: cardgenerator2,
                                width: 120.67,
                                height: 125.1,
                                path:
                                    "Images/cards/homepage/2/2_4/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                min: 3),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: Text("Categories",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 21,
                        color: Color(0xff212523))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 2, 8),
                child: SizedBox(
                  height: 116.67,
                  child: NoGlowScroll(
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 10),
                          itemCount: 3,
                          itemBuilder: (context, index) => Deck(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Category()));
                              },
                              cardgenerator: cardgenerator3,
                              width: 139,
                              height: 116.67,
                              path:
                                  "Images/cards/homepage/1_3/${cardgenerator3.getcolor}/${cardgenerator3.getshape}.png",
                              min: 3))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
