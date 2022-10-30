import 'package:flutter/material.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';

import '../data/card_generator.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';
import 'FlashcardScreen.dart';

class DeckScreen extends StatelessWidget {
  final CardGenerator cardgenerator = CardGenerator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/deckpage.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Images/banners/deckpage/0.png"),
                  fit: BoxFit.fill,
                ),
              ),
              width: 400,
              height: 410,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
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
                          "Meteorology",
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
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Combined Meteorology\nVocabulary Lists",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "PolySans_Neutral",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff514F55),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "48 Flashcards",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "PolySans_Median",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff514F55),
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/favorite.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 48,
                                  height: 48,
                                  child: const Text(""))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/filter.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 48,
                                  height: 48,
                                  child: const Text(""))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/profile.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: const Text(""))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Salma Ahmed",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "PolySans_Slim",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff514F55),
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/star-line.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 23,
                                  height: 23,
                                  child: const Text(""))),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "3.5",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "PolySans_Slim",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff514F55),
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 7),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/bar.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 136.71,
                            height: 55,
                            child: const Center(
                                child: Text(
                              "Study",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "PolySans_Median",
                              ),
                            )))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 25, 7),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/bar.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 136.71,
                            height: 55,
                            child: const Center(
                                child: Text(
                              "Test",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "PolySans_Median",
                              ),
                            )))),
                  ),
                ),
              ],
            ),
            Expanded(
              child: NoGlowScroll(
                child: ListView(
                  children: List.generate(
                      6,
                      (index) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: 21.0, right: 21, left: 21),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Deck(
                                  cardgenerator: cardgenerator,
                                  width: 163.13,
                                  height: 158.67,
                                  path:
                                      "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                  min: 3,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Flashcard()));
                                  },
                                ),
                                Deck(
                                  cardgenerator: cardgenerator,
                                  width: 163.13,
                                  height: 158.67,
                                  path:
                                      "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                  min: 3,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Flashcard()));
                                  },
                                ),
                              ],
                            ),
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
