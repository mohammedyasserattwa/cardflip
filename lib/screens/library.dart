// ignore_for_file: unnecessary_new


import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/widgets/deck.dart';
import 'package:go_router/go_router.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../models/libraryModel.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';

class Library extends StatefulWidget {
  const Library({key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  // LibraryModel model = new LibraryModel(new DummyData());
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
              image: AssetImage("Images/backgrounds/librarypage.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "Images/banners/librarypage/${cardgenerator.librarycolor}.png"),
                  fit: BoxFit.cover,
                ),
              ),
              width: 400,
              height: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "Images/icons/more-fill.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: const Text(""))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Library",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: "PolySans_Median",
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 48,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 0, 7),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("Images/icons/allsquare.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: const Center(
                                child: Text(
                              "All",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "PolySans",
                              ),
                            )))),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 7),
                  child: Text(
                    "Created \nby You",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "PolySans_Neutral",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 7),
                  child: Text(
                    "Created \nby Others",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "PolySans_Neutral",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 7),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go('/Home/Library/Adddeck');
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/add.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: Text(""))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 25, 7),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/filter.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: Text(""))),
                  ),
                ),
              ],
            ),
            Expanded(
              child: NoGlowScroll(
                child: ListView(
                  children: new List.generate(
                      6,
                      (index) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Deck(
                                      cardgenerator: cardgenerator,
                                      width: 163.13,
                                      height: 158.67,
                                      min: 3,
                                      onTap: () {
                                        GoRouter.of(context)
                                            .go('/Home/Library/Deck');
                                      },
                                      path:
                                          "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                  Deck(
                                      cardgenerator: cardgenerator,
                                      width: 163.13,
                                      height: 158.67,
                                      min: 3,
                                      onTap: () {
                                        GoRouter.of(context)
                                            .go('/Home/Library/Deck');
                                      },
                                      path:
                                          "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
