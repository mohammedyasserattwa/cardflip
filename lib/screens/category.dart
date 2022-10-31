// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:ffi';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/categoryModel.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../widgets/deck.dart';
import '../widgets/navibar.dart';
import 'package:go_router/go_router.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  CategoryModel model = new CategoryModel();
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
                  image: AssetImage("Images/backgrounds/Categorygeography.png"),
                  fit: BoxFit.cover),
            ),
            child: NoGlowScroll(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/arrow-left-s-line.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Text(""))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("Images/vectors/geography.png"),
                              fit: BoxFit.cover,
                              scale: 0.5,
                            ),
                          ),
                          width: 329,
                          height: 298,
                          // width: 475.27,
                          // height: 350.41,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Geography",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 36,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 3; i++)
                                Column(
                                  children: [
                                    if (i == 0)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Deck(
                                                  onTap: () {},
                                                  cardgenerator: cardgenerator,
                                                  // width: 148,
                                                  // height: 119,
                                                  width: 170,
                                                  height: 135,
                                                  path:
                                                      "Images/cards/categorypage/1/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                                  min: 2)),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Deck(
                                                  onTap: () {},
                                                  cardgenerator: cardgenerator,
                                                  // width: 148,
                                                  // height: 119,
                                                  width: 170,
                                                  height: 135,
                                                  path:
                                                      "Images/cards/categorypage/1/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                                  min: 2)),
                                        ],
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Deck(
                                                onTap: () {},
                                                cardgenerator: cardgenerator2,
                                                // width: 148,
                                                // height: 119,
                                                width: 360,
                                                height: 137,
                                                path:
                                                    "Images/cards/categorypage/2/${cardgenerator2.getcolor}/${cardgenerator2.getshape}.png",
                                                min: 2),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Deck(
                                                    onTap: () {},
                                                    cardgenerator:
                                                        cardgenerator3,
                                                    // width: 148,
                                                    // height: 119,
                                                    width: 175,
                                                    height: 119,
                                                    path:
                                                        "Images/cards/categorypage/3_1/${cardgenerator3.getcolor}/${cardgenerator3.getshape}.png",
                                                    min: 2)),
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                child: Deck(
                                                    onTap: () {},
                                                    cardgenerator:
                                                        cardgenerator3,
                                                    // width: 148,
                                                    // height: 119,
                                                    width: 165,
                                                    height: 119,
                                                    path:
                                                        "Images/cards/categorypage/3_2/${cardgenerator3.getcolor}/${cardgenerator3.getshape}.png",
                                                    min: 2)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10)
                            ],
                          )),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
