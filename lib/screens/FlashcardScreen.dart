import "package:flutter/material.dart";

import '../widgets/navibar.dart';

class Flashcard extends StatelessWidget {
  const Flashcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/FlashcardBackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 30, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(""),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/close_button.png")),
                      ),
                    ),
                    Container(
                      child: Text(""),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/more-three.png")),
                      ),
                    )
                  ]),
            ),
            Stack(
              children: [
                Container(
                  width: 343,
                  height: 511.97,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Images/cards/flashcards/2.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Text(""),
                ),
                Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      width: 343,
                      height: 511.97,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/cards/flashcards/1.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Text(""),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 60),
                    Container(
                      width: 343,
                      height: 550.97,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/cards/flashcards/0.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Text(""),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: NavBar(),
    );
  }
}
